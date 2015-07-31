#!/usr/bin/env python 
#!-*- coding: utf-8 -*-

"""
Language Identifiaction and Transliteration Tool

A token level language identification and transliteration tool in 
code-mixed queries in English and any of the following Indian languages 
viz. Bengali, Gujarati, Hindi, Malayalam, Tamil, Telegu and Kannada.
"""

import re
import sys
import json
import argparse
import unicodedata as ud

import kenlm
import numpy as np

import ind_trans as tn
from wxILP import wxilp

__version__	= "2.1"
__license__	= "MIT"
__author__	= "Irshad Ahmad"
__credits__	= ["Irshad Ahmad", "Riyaz Ahmad"]
__maintainer__	= "Irshad Ahmad"
__email__ =	[
		"irshad.bhat@research.iiit.ac.in",
		"riyaz.bhat@research.iiit.ac.in",
		"bhatirshad127@gmail.com"
		]

class LIT():
    
    """
    Token level language identifcation is carried out using language models of each 
    defined language developed with IRSTLM tool-kit. For each language two models 
    are developed, one for individual words (5-gram character context) and other for 
    5-gram word context. Decision rule is made using a linear combination of 
    probabilities obtained from the language models.
    """

    def __init__(self, INFILE, OUTFILE, labels):
	
	self.labels = labels
	self.INFILE = INFILE
	self.OUTFILE = OUTFILE
	self.wxp = wxilp(order="wx2utf")
	self.tag_dct = {tag:i for i,tag in enumerate(labels)}
	self.tree, self.queue, self.blm_wp, self.blm_sp = list(), list(), list(), list()

	# load decision trees
	for tag in self.labels:
	    if tag == "eng": 
		self.tree.append("_")
		continue
	    if tag == "kan":
		tag = "mal"
	    with open('decision_trees/eng-%s.json' %tag) as fp:
    		self.tree.append(json.load(fp))

	# load language-models
	for tag in self.labels:
	    self.blm_wp.append(kenlm.LanguageModel('blm_models/{}.tk.blm'.format(tag)))
	    self.blm_sp.append(kenlm.LanguageModel('blm_models/{}.ts.blm'.format(tag)))

	# load emoticon set
	with open('extras/emoticons.txt') as fp:
	    self.emoticons = set(fp.read().split('\t'))

	self.reg = re.compile(r"(^[^a-zA-Z0-9]+|[^-'a-zA-Z0-9]+|[^a-zA-Z0-9]+$)")

    def mapper(self, word, ip_tag, op_tag):
        bases={
        'hindi'     :   2304,
        'tamil'     :   2944,
        'telugu'    :   3072,
        'bengali'   :   2432,
        'gujrati'   :   2688,
        'punjabi'   :   2560,
        'kannada'   :   3200,
        'malayalam' :   3328
        }
	map_string = [unichr(ord(letter)-bases[op_tag] + bases[ip_tag]) \
			if ord(letter) in range(3328, 3456) else letter \
			for letter in list(word.decode("utf-8"))] 
	    
	return "".join([ch for ch in map_string if ud.category(unichr(ord(ch))) != "Cn"])

    def transliterate(self, word, tag):
	"""Transliterate words predicted as Indic-words to their native
	scripts using 'ind_trans.py' script and Indic-convertor tool-kit"""
	
	# transliterate to WX
	wx = tn.RomanConvertor(self.tree[self.tag_dct[tag]], word, tag).predict()
	
	if tag == 'guj':
	    self.OUTFILE.write("%s\\%s=%s" %(word, tag.title(), wx))
	    return
	
	if tag == "kan":
	    unicodeString = self.wxp.wx2utf(wx, "mal")	
	    self.OUTFILE.write("%s\\Kan=%s" %(word, self.mapper(unicodeString, "kannada", "malayalam")))
	    return
	    	
	# convert WX to native scripts
	unicodeString = self.wxp.wx2utf(wx, tag)	
    	self.OUTFILE.write("%s\\%s=%s" %(word, tag.title(), unicodeString))

    def print_queue(self, i):

	"""Assign \O (other) tag to all strings in queue"""
	while self.queue:
	    if self.queue[0][1] == i:
		self.OUTFILE.write(self.queue.pop(0)[0] + '\O')
	    else:
		break
    	
    def check(self, word, sen):
	
	"""
	compute character-level and word-level CPs of words and use the 
	linear combination of these scores to predict language tags
	"""
	# compute character level and word level language probabilities
	lang_probability = list()
	for i,tag in enumerate(self.labels):
	    if tag == 'eng':
		word_probability = self.blm_wp[i].score(' '.join(word))
		sen_probability = self.blm_sp[i].score(sen)
	    else:
		word_probability = self.blm_wp[i].score(' '.join(word.lower()))
		sen_probability = self.blm_sp[i].score(sen.lower())
	    lang_probability.append(word_probability + sen_probability)

	# find tag with highest probability 
	idx = np.argmax(lang_probability)
	tag = self.labels[idx]
	if tag=='eng':
	    self.OUTFILE.write("{}\Eng".format(word))
	else:
	    if args.flag == 'T':
		self.transliterate(word, tag)
	    else:
		self.OUTFILE.write("{}\{}".format(word,tag.title()))
	    
    def predict(self, word_list):

	"""
	Takes a list of words, records context (3-gram) and labels non-alphabetic 
	words with '\O' (Other). Each word is identified using 	character-level 
	language models of individual words and their context (3-gram).
	"""
	
        i, tri_gram = 0, ['']*3

        for word in word_list:
            if not word:
                continue
	    if word in self.emoticons:
		self.OUTFILE.write("%s\\EMT" %word)
		continue
            # label words that doesn't contain any alphabet with \O tag                     
            if not re.search(r'[a-zA-Z]',word):
		step  = len(' '.join(tri_gram).split())
		if not step:
		    self.OUTFILE.write(word+"\O")
		    continue
		self.queue.append((word, i+3))
		continue
            # split leading and trailing non-alphabetic characters of a word
            words = re.sub(self.reg, r' \1 ', word).split()
            for word in words:
                # label words that doesn't contain any alphabet with \O tag                 
                if not re.search(r'[a-zA-Z]',word):
		    step  = len(' '.join(tri_gram).split())
		    if not step:
			self.OUTFILE.write(word+"\O")
			continue
		    self.queue.append((word, i+3))
		    continue
                # record context of word (3-gram)
                if i < 2:
                    i+=1
                    tri_gram[i] = word
                    continue
                cur_word = tri_gram[1]
                sen = ' '.join(''.join(tri_gram))
                tri_gram[:2] = tri_gram[1:3]
                tri_gram[-1] = word
		i+=1
		self.print_queue(i)
                self.check(cur_word, sen)

	# NOTE last 2 words of a sentence
	for j in range(1,3):
	    if tri_gram[j]:
		i+=1
		self.print_queue(i)
		self.check(tri_gram[j], ' '.join(''.join(tri_gram[j-1:])))

	if self.queue:
	    self.print_queue(self.queue[0][1])

    def identify(self):
	
	"""Passes list of words in a line to 'predict' function"""

	for line in self.INFILE:
	    if not line:
		self.OUTFILE.write('\n')
		continue
	    sentences = re.sub(r'([.?]\s\s*)([A-Z0-9])', r'\1\n\2', line).split('\n')
	    for sen in sentences:
		words = sen.split()
		self.predict(words)
	    self.OUTFILE.write('\n')
    
if __name__ == "__main__":

    """
    Program entry point. 
    Script takes three arguments:
    1. Code-mixed text file 
    2. Language tags (Optional): [hin, ban, guj, mal, tam, kan, tel]
    3. Transliteration flag (Optional)
    """

    lang_tags = ['ban', 'eng', 'guj', 'hin', 'kan', 'mal', 'tam', 'tel']
    lang_help = 'Any language combination from the set : [%s]' %'|'.join(lang_tags)
    parser = argparse.ArgumentParser(prog="litcm", description="Language Identification & Transliteration in Code-Mixing")
    parser.add_argument('--v', action="version", version="%(prog)s 2.1")
    parser.add_argument('--l', metavar='languages', dest='tag', help=lang_help)
    parser.add_argument('--i', metavar='input', dest="INFILE", type=argparse.FileType('r'), default=sys.stdin, help="<input-file>")
    parser.add_argument('--o', metavar='output', dest="OUTFILE", type=argparse.FileType('w'), default=sys.stdout, help="<output-file>")
    parser.add_argument('--t', metavar='transliteration', dest='flag', help="set this to 'T' for back-transliteration of Indic words")

    args = parser.parse_args()

    if args.tag:
	labels = [tag.lower() for tag in args.tag.split()]
	assert len(labels) >= 2
	assert set(labels).issubset(set(lang_tags))
    else:
	labels = lang_tags

    idf = LIT(args.INFILE, args.OUTFILE, labels)
    idf.identify()

    args.INFILE.close()
    args.OUTFILE.close()
    


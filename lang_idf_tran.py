#!/usr/bin/env python 
#!-*- coding: utf-8 -*-

"""
Language Identifiaction Tool

A token level language identification and transliteration tool in 
code-mixed queries in English and any of the given 7 Indian languages 
viz Bengali, Gujarati, Hindi, Malayalam, Tamil, Telegu and Kannada.
"""

import re
import json
import argparse
import commands as cm
import unicodedata as ud

import kenlm
import numpy as np

import ind_trans as tn

__version__ = "2.1"
__license__ = "MIT"
__author__ = "Irshad Ahmad"
__credits__ = ["Irshad Ahmad", "Riyaz Ahmad"]
__maintainer__ = "Irshad Ahmad"
__email__ = ["irshad.bhat@research.iiit.ac.in",
	     "riyaz.bhat@research.iiit.ac.in",
	     "bhatirshad127@gmail.com"]

class LIT():
    
    """
    Token level language identifcation is carried out using language models of each 
    defined language developed with IRSTLM tool-kit. For each language two models 
    are developed, one for individual words (5-gram character context) and other for 
    5-gram word context. Decision rule is made using a linear combination of 
    probabilities obtained from the language models.
    """

    def __init__(self, fp, labels):
	
	self.fp = fp
	self.labels = labels
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

	#self.kan_null = [3312, 3315, 3252, 3316, 3317, 3287, 3273, 3321,
	#		3258, 3322, 3323, 3324, 3325, 3278, 3326, 3327]
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
	    
	#return "".join([ch if ord(ch) not in self.kan_null else "" for ch in list(map_string)])
	return "".join([ch for ch in map_string if ud.category(unichr(ord(ch))) != "Cn"])

    def transliterate(self, word, tag):
	"""Transliterate words predicted as Indic-words to their native
	scripts using 'ind_trans.py' script and Indic-convertor tool-kit"""
	
	# transliterate to WX
	wx = tn.RomanConvertor(self.tree[self.tag_dct[tag]], word, tag).predict()
	
	if tag == 'guj':
	    print "%s\\%s=%s" %(word, tag.title(), wx),
	    return
	
	if tag == "kan":
	    unicodeString = cm.getoutput("echo %s | bash $convertorIndic/wx2utf_run.sh \
						    text %s 2> /dev/null" %(wx, "mal"))
	    print "%s\\Kan=%s" %(word, self.mapper(unicodeString, "kannada", "malayalam")), 
	    return
	    	
	# convert WX to native scripts
    	unicodeString = cm.getoutput("echo %s | bash $convertorIndic/wx2utf_run.sh \
						    text %s 2> /dev/null" %(wx, tag))
    	print "%s\\%s=%s" %(word, tag.title(), unicodeString), 

    def print_queue(self, i):

	"""Assign \O (other) tag to all strings in queue"""
	while self.queue:
	    if self.queue[0][1] == i:
		print self.queue.pop(0)[0] + '\O',
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
	    print "{}\Eng".format(word),
	else:
	    if args.flag == 'T':
		self.transliterate(word, tag)
	    else:
		print "{}\{}".format(word,tag.title()),
	    
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

            # label words that doesn't contain any alphabet with \O tag                     
            if not re.search(r'[a-zA-Z]',word):
		step  = len(' '.join(tri_gram).split())
		if not step:
		    print word+"\O",
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
			print word+"\O",
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

	for line in self.fp:
	    if not line:
		print
		continue
	    sentences = re.sub(r'([.?]\s*)([A-Z])', r'\1\n\2', line).split('\n')
	    for sen in sentences:
		words = sen.split()
		self.predict(words)
	    print 
    
if __name__ == "__main__":

    """
    Program entry point. 
    Script takes two arguments:
    1. Code-mixed text file 
    2. One of the Indian language tags: [hin, ban, guj, mal, tam, kan, tel]
    """

    parser = argparse.ArgumentParser(description="Language Identification in Code-Mixing")
    parser.add_argument('--f', dest='file_', required=True, help='Input code-mixed file')
    parser.add_argument('--t', dest='tag',  help='Any space seperated tag combinations in quotes \
						    from the list: [ban, eng, guj, hin, kan, mal, \
						    tam, tel] e.g \'hin eng tel\'')
    parser.add_argument('--o', dest='flag', help="set this to 'T' for back-transliteration")
    parser.add_argument('-o', dest='flag', help="set this to 'T' for back-transliteration")

    args = parser.parse_args()
    lang_tags = ['ban', 'eng', 'guj', 'hin', 'kan', 'mal', 'tam', 'tel']

    if args.tag:
	labels = args.tag.split()
	labels = [tag.lower() for tag in args.tag.split()]
	assert len(labels) >= 2
	assert set(labels).issubset(set(lang_tags))
    else:
	labels = lang_tags

    with open(args.file_) as fp:
	idf = LIT(fp, labels)
	idf.identify()
    


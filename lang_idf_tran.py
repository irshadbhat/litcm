#!/usr/bin/env python 
#!-*- coding: utf-8 -*-

"""
Language Identifiaction Tool

A token level language identification and transliteration tool in 
code-mixed queries in English and any of the given 7 Indian languages 
viz Bengali, Gujarati, Hindi, Malayalam, Tamil, Telegu and Kannada.
"""

import re
import argparse
import commands as cm

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

    def __init__(self, fp):
	
	self.fp = fp
	self.tree = np.load('decision_tree_clf/toWX.npy')[0]

	self.queue = list()
	self.reg = re.compile(r"(^[^a-zA-Z0-9]+|[^-'a-zA-Z0-9]+|[^a-zA-Z0-9]+$)")

	# load language-models
        self.blm_eng_wp = kenlm.LanguageModel('blm_models/eng.tk.blm')
        self.blm_eng_sp = kenlm.LanguageModel('blm_models/eng.ts.blm')
        self.blm_ind_wp = kenlm.LanguageModel('blm_models/{}.tk.blm'.format(args.tag))
        self.blm_ind_sp = kenlm.LanguageModel('blm_models/{}.ts.blm'.format(args.tag))

    def transliterate(self, word):

	"""
    	Transliterate words predicted as Indic-words to their native
	scripts using 'ind_trans.py' script and Indic-convertor tool-kit
    	"""
	
	# transliterate to WX
	toWx = tn.RomanConvertor(self.tree, word).predict()
    	toWx = re.sub("_","",toWx)

	# convert WX to native scripts
    	if args.tag == "guj":
    	    unicodeString = cm.getoutput("echo"+" "+toWx+" | \
    	    bash "+" "+"$convertorIndic/wx2utf_run.sh text hin 2> /dev/null")
    	    print word+"\G="+mapper(unicodeString, "gujrati"),
    	else:
    	    unicodeString = cm.getoutput("echo"+" "+toWx+" "+" | \
    	    bash "+" "+"$convertorIndic/wx2utf_run.sh text " + " " + args.tag +" "+"2> /dev/null")
    	    print word+"\\"+args.tag[0].upper()+"="+unicodeString,

    def print_queue(self, i):

	"""Assign \O (other) tag to all strings in queue"""
	while self.queue:
	    if self.queue[0][1] == i:
		print self.queue.pop(0)[0]+'\O',
	    else:
		break
    	
    def check(self, word, sen):
	
	"""
	compute character-level and word-level CPs of words and use the 
	linear combination of these scores to predict language tags
	"""
	# compute character level and word level language probabilities
	wp_eng = self.blm_eng_wp.score(' '.join(word))
	sp_eng = self.blm_eng_sp.score(sen)
	wp_ind = self.blm_ind_wp.score(' '.join(word.lower()))
	sp_ind = self.blm_ind_sp.score(sen.lower())

	# take linear combination of obtained probabilities to make a decision rule 
	lang1 = wp_eng + sp_eng
	lang2 = wp_ind + sp_ind	
	if lang1 > lang2:
	    print "{}\E".format(word),
	else:
	    if args.flag == 'T':
		print "{}\{}".format(word,args.tag[0].upper()),
	    else:
		self.transliterate(word)
	    
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

	# last 2 words of a sentence
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
    parser.add_argument('-f', dest='file_', required=True, help='Input code-mixed file')
    parser.add_argument('-t', dest='tag', required=True, help='One of the following tags: \
							[hin, ban, guj, mal, tam, kan, tel]')
    parser.add_argument('-o', dest='flag', help="set this to 'T' to skip transliteration")

    args = parser.parse_args()

    with open(args.file_) as fp:
	idf = LIT(fp)
	idf.identify()
    


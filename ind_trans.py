#!/usr/bin/env python 
#!-*- coding: utf-8 -*-

"""Roman to WX transliterator for Indic words in Roman Script"""

import re
from collections import Counter 

__version__ = "2.1"
__license__ = "MIT"
__author__ = "Irshad Ahmad"
__maintainer__ = "Irshad Ahmad"
__email__ = ["irshad.bhat@research.iiit.ac.in",
             "bhatirshad127@gmail.com"]

class RomanConvertor ():

    """Transliterates Indic words in Roman script to WX"""
    def __init__ (self, tree_, input_):
	self.tree_ = tree_
	self.input_ = input_.lower()
	self.transliterated_ = str()

    def find(self, x, tree):

	"""Predicts WX character for the given Roman character"""
	i=tree.keys()[0]
	try:
	    subset=tree[i][x[i]]
	except:
	    best_val=str(tree[i])
	    res=re.findall(r"\s'([a-zA-Z_]+?)',",best_val)
	    res_tpl=Counter(res).most_common()
	    self.transliterated_ += res_tpl[0][0]
	    return
	if type(subset)==dict:
	    self.find(x,subset)
	else:
	    self.transliterated_ += subset
	    return

    def predict(self):

	"""
	Takes a word as input, splits it into letters, records context 
	(previous three and next three characters) of each letter in a 
	list and passes the list to 'find' function. 
	"""
	p1=p2=p3="_"
	data_point=[]
	for i in range(len(self.input_)):
	    if not self.input_[i].isalpha():
	    	self.transliterated_ += self.input_[i]
		continue
	    data_point.append(p1)
	    data_point.append(p2)
	    data_point.append(p3)
	    data_point.append(self.input_[i])
	    try:
		data_point.append(self.input_[i+1])
	    except:
	    	data_point.append("_")
	    try:
	    	data_point.append(self.input_[i+2])
	    except:
	    	data_point.append("_")
	    try:
	    	data_point.append(self.input_[i+3])
	    except:
		data_point.append("_")
	    self.find(data_point, self.tree_)
	    p1=p2
	    p2=p3
	    p3=self.input_[i]
	    data_point=[]
	return self.transliterated_

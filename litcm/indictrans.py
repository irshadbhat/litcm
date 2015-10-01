#!/usr/bin/env python 
#!-*- coding: utf-8 -*-

"""Roman to WX transliterator for Indic words in Roman Script"""

import re
import ast
from collections import Counter 

__version__     = "1.0.0"
__license__     = "MIT"
__author__      = "Irshad Ahmad"
__maintainer__  = "Irshad Ahmad"
__email__       = ["irshad.bhat@research.iiit.ac.in",
                   "bhatirshad127@gmail.com"]

class RomanConvertor():

    """Transliterates Indic words in Roman script to WX"""
    def __init__ (self, tree_, input_, tag):
        self.tag = tag
        self.tree_ = tree_
        self.input_ = input_.lower()
        self.transliterated_ = str()

    def find(self, x, tree):
        """
        Predicts transliterated character of the given data-point 
        (character with context) based on certain decisions on the 
        various attributes of the data-point
        """
        root = tree.keys()[0]
        try:
            subset = tree[root][x[int(root)]]
        except KeyError, e:
            best_val = str(tree[root])
            res = re.findall(r":\s(u'.*?')", best_val)
            res_tpl = Counter(res).most_common(1)
            pred = ast.literal_eval(res_tpl[0][0])
            self.transliterated_ += pred
            return

        if isinstance(subset, dict):
            self.find(x, subset)
        else:
            self.transliterated_ += subset

    def transliterate(self):

        """
        Takes a word as input, splits it into letters, records context 
        (previous three and next three characters) of each letter in a 
        list and passes the list to 'find' function. 
        """
        p1 = p2 = p3 ="_"
        data_point = list()
        for i in range(len(self.input_)):
            if not self.input_[i].isalpha():
                self.transliterated_ += self.input_[i]
                continue
            data_point.extend([p1, p2, p3, self.input_[i]])
            try:
                data_point.append(self.input_[i+1])
            except IndexError, e:
                data_point.append("_")
            try:
                data_point.append(self.input_[i+2])
            except IndexError, e:
                data_point.append("_")
            try:
                data_point.append(self.input_[i+3])
            except IndexError, e:
                data_point.append("_")
            self.find(data_point, self.tree_)
            p1, p2, p3 = p2, p3, self.input_[i]
            data_point = list()
        
        self.transliterated_ = self.transliterated_.replace("_", "")
        
        if not self.transliterated_:
            return ""
        #if self.transliterated_[-1] not in 'aeiouAEIOU' and self.tag != 'guj':
        #    self.transliterated_ += 'a'
        return self.transliterated_.encode('utf-8')

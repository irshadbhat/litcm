#!/usr/bin/env python

import re
from collections import Counter 

class RomanConvertor ():
	def __init__ (self, tree_, input_):
		self.tree_ = tree_
		self.input_ = input_.lower()
		self.transliterated_ = str()

	def find(self, x, tree):
		"""
		This function uses the trained decision tree to predict the correct WX character for the given Roman character with its 
		context. 
		"""
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
		This function takes a single word as input. Split it into characters and for each alphabetic character identify its context
		(previous three and next three characters) and passes the whole to find function. 
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

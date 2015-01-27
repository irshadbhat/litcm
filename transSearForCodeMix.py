#!/usr/bin/env python -*- coding: utf-8 -*-

__Version__ = "1.0"
__Author__ = "Irshad Ahmad Bhat"


import sys
import re, os
import enchant
import commands
import numpy as np
import cPickle as pic
from math import log10
import indicConvertor as st
import argparse 

def mapper(word, output):
    bases={
    'hindi':2304,
    'bengali':2432,
    'gujrati':2688,
    'kannada':3200,
    'punjabi':2560,
    'telugu':3072,
    'tamil':2944,
    'malayalam':3328
    }
    return "".join([unichr(ord(letter)-bases['hindi']+bases[output]) for letter in list(word.decode("utf-8"))]).encode("utf-8")

def getPriors():

    """
    This function returns prior probabilities for lang1 and lang2. 
    Prior probabilities are counted using word count in training data set.
    """
    priorCount={'eng':94394.0,'ben':293236.0,'hin':329090.0,'guj':40889.0,'tam':55370.0,'mal':128117.0,'kan':579736.0}
    language1 = priorCount['eng']                
    language2 = priorCount[args.tag.lower()]         
    total = language1 + language2
    priors = dict(zip(['lan1','lan2'],[language1/float(total),language2/float(total)]))
    return priors

def loadFiles():

    """
    This function loads two binary files: 
    1. SVM classifier
    2. Decision tree for Roman to WX conversion.
    """
    fp=open(path+r"/SVMclassifiers/"+args.tag+'.pic','r')
    clf=pic.load(fp)
    fp.close()
    fp=open(path+r"/DecisionTreeClassifiers/toWx.pic",'r')
    tree=pic.load(fp)
    fp.close()
    return clf,tree

def transliterate(lang,word):

    """
    This function transliterates words which are predicted as Indic-words.
    These are passed on to RomanConvertor which generates 
    their WX and then this Wx is passed to convertor-indic tool-kit 
    to convert WX to native scripts.
    """
    if lang==0.0:
        print word+"\E",
    else:
        toWx = st.RomanConvertor(tree, word).predict()
        toWx = re.sub("_","",toWx)
        if args.tag == "guj":
	    unicodeString = commands.getoutput("echo"+" "+toWx+" | \
	    bash "+" "+"$convertorIndic/wx2utf_run.sh text hin 2> /dev/null")
	    print  word+"\G="+mapper(unicodeString, "gujrati"),
	else:
	    unicodeString = commands.getoutput("echo"+" "+toWx+" "+" | \
	    bash "+" "+"$convertorIndic/wx2utf_run.sh text " + " " + args.tag +" "+"2> /dev/null")
	    print word+"\\"+args.tag[0].upper()+"="+unicodeString,

def createVec(words):

    """
    This function creates vector for each word for language prediction purpose.
    It filters out named-entities, punctuations etc. For each word dictionary flag 
    is obtained using Enchant and lang1-CPP and lang2-CPP are computed. These three 
    features are packed in a vector which is then used by SVM classifier.
    """
    for newWord in words:
	if newWord == '':continue
	if re.search(r"\W+",newWord):
	    print newWord+"\O",
	    continue
	flag = dictionary.check(newWord.lower())
	if (not flag) and (len(newWord)>3):
	    flag=dictionary.check(newWord.title())
	if flag==True:
	    flag=1.0
	else:
	    flag=0.0
	vector=[]
	LP=['/blm_ngrams/training.eng','/blm_ngrams/training.'+args.tag.lower()]
	for i in [1,2]:
	    output = commands.getoutput("echo"+" "+" ".join(list(newWord))+" | /usr/bin/query "+path+LP[i-1]+".blm 2> test.log")
	    score = output.strip().split()[-1]
	    assert float(score)
	    antiLog = 10**float(score)
	    vector.append(antiLog * priors['lan'+str(i)])
	vector.append(flag)
	lang = clf.predict(vector)[0]	    #SVM classifier
	transliterate(lang,newWord)

if __name__ == "__main__":

    """
    Program entry point. 
    Takes two arguments:
    1. Codemixed text file 
    2. One of the Indian language tags:	[hin, ben, guj, mal, tam, kan]
    """
    parser = argparse.ArgumentParser(description="Language Identification & Transliteration of Indic-words!")
    parser.add_argument('-f' , dest='input', required=True  , help='Input code-mixed data file')
    parser.add_argument('-t' , dest='tag', required=True  , help='One of the following tags: [hin, ben, guj, mal, tam, kan]')

    args = parser.parse_args()

    path = os.getcwd()
    priors = getPriors()
    clf,tree = loadFiles()
    dictionary = enchant.Dict("en_US")
    for line in open(args.input):
	if line == '':
	    print
	    continue
	for word in line.split():
	    words=re.sub(r"(^[^\w]+|[^\w]+$|[^\w]+)",r' \1 ',word.strip()).strip().split()
	    vector = createVec(words)	
	print

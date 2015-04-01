# Language Identification and Transliteration (LIT): 

This tool is used for language identification and transliteration of Indic-words in code-mixed data. 

The tool is meant for seven Indian languages; Hindi, Bengali, Kanadda, Tamil, Malayalam, Telegu and Gujrati and English code mixed with each other.  

The input file should contain text in Roman script in any of the above eight languages. 

It is not necessary to mention the languages used in the code-mixed data but if it is known that not all the languages are present in the code-mixed text then it is better to pass an argument to the script mentioning only those languages that are present in the code-mixed text as shown below in Usage section. Note that if none of the languages are passed, then by default the script assumes that all the above eight languages are present in the text, and predicts words accordingly.

## Requirements:

    kenlm. Can be installed from 'https://github.com/kpu/kenlm'
    numpy. Can be installed via 'sudo apt-get install python-numpy'

## Preprocessing:

    1.  Unzip all files in blm_models directory using the following command:

	    gunzip blm_models/*

    2.  Move to convertor-indic-1.4.9 directory and copy its path using pwd command to the .bashrc file as shown below:

	    export convertorIndic="path"    
	    e.g.
	    export convertorIndic="/home/irshad/LIT/convertor-indic-1.4.9"    


### How to use ??

    python lang_idf_tran.py -f inputfile -t 'tel tam hin' -o[optional] T

Second argument (-t) is optional and is a subset of eight language tags; {hin, ban, guj, tam, mal, kan, tel, eng}.

Pass second agrument if there is a prior knowledge that only certain languages are present in the text. The languages passed should be from the given set of eight languages, enclosed in quotes and each language tag seperated by a space as shown. 

Third (-o) arguments is also optional. Set the third argument to T to include transliteration of Indic words to their native scripts as well.



## Contact:

    Irshad Ahmad Bhat
    MS-CSE IIITH, Hyderabad
    bhatirshad127@gmail.com
    irshad.bhat@research.iiit.ac.in


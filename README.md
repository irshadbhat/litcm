# Language Identification and Transliteration (LIT): 

This tool is used for language identification and transliteration of Indic-words in code-mixed data. 

The tool is meant for English and seven Indian languages viz. Hindi, Bengali, Kanadda, Tamil, Malayalam, Telegu and Gujrati, code mixed with each other.  

The input file can have words in any of the above mentioned languages in Roman script.

It is not necessary to mention the languages used in the code-mixed data but if it is known that all the languages are not present in the code-mixed text, it is better to pass an argument to the script mentioning only those languages that are present in the code-mixed text as shown below in Usage section. Note that if none of the languages are passed, then by default the script assumes that all the above eight languages are present in the text, and predicts words accordingly.

## Requirements:

    kenlm. Can be installed from 'https://github.com/kpu/kenlm'
    numpy. Can be installed via 'sudo apt-get install python-numpy'

## Preprocessing:

    1.  Unzip all files in blm_models directory using the following command:

	    gunzip blm_models/*

### How to use ??

    python lang_idf_tran.py --i inputfile --o[optional] outputfile -l[optional] hin tel eng -t[optional] T

    --i input            <input-file>
    --o output           <output-file>
    --l languages        Any language combination from the set: [ban|eng|guj|hin|kan|mal|tam|tel]
    --t transliteration  set this to 'T' for back-transliteration of Indic words

Language argument (*-l*) is optional and is a subset of eight language tags; {hin, ban, guj, tam, mal, kan, tel, eng}.

Pass language agrument if there is a prior knowledge that only certain languages are present in the text. The languages passed should be from the given set of eight languages.

Transliteration arguments (*-t*) is also optional. Set this argument to T to back transliterate identified Indic words to their native scripts.



## Contact:

    Irshad Ahmad Bhat
    MS-CSE IIITH, Hyderabad
    bhatirshad127@gmail.com
    irshad.bhat@research.iiit.ac.in


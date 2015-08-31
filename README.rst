===================================================================
Language Identification and Transliteration in Code Mixing (litcm): 
===================================================================

Language Identification and Transliteration system for Indian Languages in Roman script, code mixed with English.

The tool is meant for English and seven Indian languages viz. Hindi, Bengali, Kanadda, Tamil, Malayalam, Telegu and Gujrati, code mixed with each other.  

Input file can have words in any of the above mentioned languages in Roman script.

It is not necessary to mention the languages mixed in the data file but if there is some prior knowledge aboubt the languages mixed in the data file, it is better to pass the language codes using language argument to the script as shown in the usage section. Note that if the language argument is not used then by default the script will consider all the languages and predict words accordingly.

Installation
============

Dependencies
~~~~~~~~~~~~

**litcm** requires `NumPy`_ and `KenLM`_.

.. _`NumPy`: http://numpy.scipy.org

.. _`KenLM`: https://github.com/kpu/kenlm


Preprocessing
~~~~~~~~~~~~~

::

    Unzip all files in blm_models directory using the following command:

    gunzip litcm/blm_models/*

How to use ??
=============

.. parsed-literal::

    python lang_idf_tran.py --i inputfile --o[optional] outputfile -l[optional] hin tel eng -t[optional] T

    --i input            <input-file>
    --o output           <output-file>
    --l languages        Any language combination from the set: [ban|eng|guj|hin|kan|mal|tam|tel]
    --t transliteration  set this to 'T' for back-transliteration of Indic words

    Language argument (-**l**) is optional and is a subset of eight language tags; {hin, ban, guj, tam, mal, kan, tel, eng}.

    Transliteration arguments (-**t**) is also optional. Set this argument to T to back transliterate identified Indic words to their native scripts.


Contact
=======

::

    Irshad Ahmad Bhat
    MS-CSE IIITH, Hyderabad
    bhatirshad127@gmail.com
    irshad.bhat@research.iiit.ac.in


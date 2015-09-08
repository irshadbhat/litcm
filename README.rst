===================================================================
Language Identification and Transliteration in Code Mixing (litcm): 
===================================================================

Language Identification and Transliteration system for Indian Languages in Roman script, code mixed with English.

The tool is meant for English and seven Indian languages viz. Hindi, Bengali, Kanadda, Tamil, Malayalam, Telegu and Gujrati, code mixed with each other.  

Input file can have words in any of the above mentioned languages in Roman script.

It is not necessary to mention the languages mixed in the data file but if there is some prior knowledge aboubt the languages mixed in the data file, it is better to pass the language codes using language argument to the script as shown in the usage section. Note that if the language argument is not used then by default the script will consider all the languages and predict words accordingly.

References
==========

`IIIT-H System Submission for FIRE2014 Shared Task on Transliterated Search`_
`FIRE2014 IIITH`_

.. _`IIIT-H System Submission for FIRE2014 Shared Task on Transliterated Search`: https://www.academia.edu/15047617/IIIT-H_System_Submission_for_FIRE2014_Shared_Task_on_Transliterated_Search

.. _`FIRE2014 IIITH`: http://www.isical.ac.in/~fire/working-notes/2014/MSR/

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

    Unzip all files in blm_models directory:

    tar -xvzf litcm.tar.gz
    cd litcm
    gunzip litcm/blm_models/*


Install
~~~~~~~

::

    sudo python setup.py install
    

How to use ??
=============

Work with files
~~~~~~~~~~~~~~~

.. parsed-literal::

    litcm --i inputfile --o outputfile --l hin tel eng --t

    --i input            <input-file>
    --o output           <output-file, optional, default:stdout>
    --l languages        Any subset from the set: [ban|eng|guj|hin|kan|mal|tam|tel], optional, default: hin eng
    --t transliteration  set this flag for back-transliteration of identified Indic words, optional default: False

From Python
~~~~~~~~~~~

.. code:: python

	>>> from litcm import LIT
	>>> lit = LIT(['hin', 'eng'], transliteration=True)
	>>> 
	>>> text = "FOOD security bill pass ,. . acchi baat hai .... . Congress ke accoeding desh ke 80 carore logo ke liye tha ye bil ... . .. . .. . .. . .. . .. . .. . .. . . but I've a question ,. . kya yahi hai congress kaa bharat nirmaan , ki 65 years raaz karney ke baad bhi 80 carore log garib hain ... . Kitna lootego desh ko . . .. . .. . . or ek baat or jab desh kii aarthik condition ICU mai ho ,. . tab is situation mai ye bill laakr kya ram ram sath krbana hai desh kaa ..... ."
	>>> 
	>>> 
	>>> print lit.identify(text)
	FOOD\Eng security\Eng bill\Eng pass\Eng ,.\O .\O acchi\Hin=अच्ची baat\Hin=बात hai\Hin=ही ....\O .\O Congress\Hin=कांग्रेस ke\Eng accoeding\Eng desh\Hin=देश ke\Hin=क 80\O carore\Hin=कैरर logo\Hin=लोगो ke\Hin=क liye\Hin=लिये tha\Hin=ता ye\Hin=ये bil\Hin=बिल ...\O .\O ..\O .\O ..\O .\O ..\O .\O ..\O .\O ..\O .\O ..\O .\O ..\O .\O .\O but\Eng I've\Eng a\Eng question\Hin=केस्शन ,.\O .\O kya\Hin=क्या yahi\Hin=यही hai\Hin=ही congress\Hin=कांग्रेस kaa\Hin=का bharat\Hin=भारत nirmaan\Hin=निर्मान ,\O ki\Hin=की 65\O years\Hin=यिअर्स raaz\Hin=राअज़ karney\Hin=करने ke\Hin=क baad\Hin=बाद bhi\Hin=भही 80\O carore\Hin=कैरर log\Hin=लाग garib\Hin=गरीब hain\Hin=हैंअ ...\O .\O Kitna\Hin=कितना lootego\Hin=लूटेगो desh\Hin=देश ko\Hin=को .\O .\O ..\O .\O ..\O .\O .\O or\Hin=और ek\Hin=इक baat\Hin=बात or\Hin=और jab\Hin=जब desh\Hin=देश kii\Hin=की aarthik\Hin=आर्थिक condition\Eng ICU\Eng mai\Hin=माई ho\Hin=हो ,.\O .\O tab\Hin=तब is\Eng situation\Eng mai\Hin=माई ye\Hin=ये bill\Hin=बिल laakr\Hin=लाआक्र kya\Hin=क्या ram\Hin=राम ram\Hin=राम sath\Hin=सत krbana\Hin=क्रबना hai\Hin=ही desh\Hin=देश kaa\Hin=का .....\O .\O O
	>>> 
	>>> 

Contact
=======

::

    Irshad Ahmad Bhat
    MS-CSE IIITH, Hyderabad
    bhatirshad127@gmail.com
    irshad.bhat@research.iiit.ac.in


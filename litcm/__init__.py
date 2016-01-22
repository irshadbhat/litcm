#! /usr/bin/env python

import re
import sys
import argparse

from .litran import LIT

__name__       = "litcm"
__doc__        = "Language Identification and Transliteration system for Indian Languages in Roman script code mixed with English"
__author__     = "Irshad Ahmad"
__version__    = "1.0.0"
__license__    = "MIT"
__maintainer__ = "Irshad Ahmad"
__email__      = "irshad.bhat@research.iiit.ac.in"
__status__     = "Beta"
__all__        = ["litran", "indictrans", "wxILP", "main", "blm_models", "decision_trees", "extras"]

def main():
    all_tags = ['ben', 'eng', 'guj', 'hin', 'kan', 'mal', 'tam', 'tel']
    lang_help = 'Any language combination from the set: [%s]' %'|'.join(all_tags)
    parser = argparse.ArgumentParser(prog="litcm", description="Language Identification & Transliteration in Code-Mixing")
    parser.add_argument('--v', action='version', version="%(prog)s 1.0")
    parser.add_argument('--i', metavar='input', dest="INFILE", type=argparse.FileType('r'), default=sys.stdin, help="<input-file>")
    parser.add_argument('--o', metavar='output', dest="OUTFILE", type=argparse.FileType('w'), default=sys.stdout, help="<output-file>")
    parser.add_argument('--l', metavar='languages', dest='lang_tags', nargs='+', help=lang_help)
    parser.add_argument('--t', dest='flag', action='store_true', help="set this flag for back-transliteration of Indic words")

    args = parser.parse_args()

    if args.lang_tags:
        labels = [tag.lower() for tag in args.lang_tags]
        assert len(labels) >= 2
        assert set(labels).issubset(set(all_tags))
    else:
        labels = ['hin', 'eng']

    lit = LIT(labels, transliteration=args.flag)
    for line in args.INFILE:
        if not line.strip():
            args.OUTFILE.write('\n')
            continue
        litsen = lit.identify(line)
        args.OUTFILE.write("%s\n" %litsen)

    #close files
    args.INFILE.close()
    args.OUTFILE.close()

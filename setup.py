#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

import sys
import os.path
import warnings
from setuptools import setup

try:
    import py2exe
except ImportError:
    if len(sys.argv) >= 2 and sys.argv[1] == 'py2exe':
        print("Cannot import py2exe", file=sys.stderr)
        exit(1)

dist_dir = os.path.dirname(os.path.abspath(__file__))
sys.stderr.write('extracting models... (this might take some time...)\n')
os.system("gunzip -kf %s/litcm/blm_models/* 2> /dev/null" %dist_dir)
sys.stderr.write('model extraction complete!\n')

py2exe_options = {
    "bundle_files": 1,
    "compressed": 1,
    "optimize": 2,
    "dist_dir": '.',
    "dll_excludes": ['w9xpopen.exe'],
}

py2exe_console = [{
    "script": "./litcm/__main__.py",
    "dest_base": "litcm",
}]

py2exe_params = {
    'console': py2exe_console,
    'options': {"py2exe": py2exe_options},
    'zipfile': None
}

if len(sys.argv) >= 2 and sys.argv[1] == 'py2exe':
    params = py2exe_params
else:
    files_spec = [
        ('share/doc/litcm', ['README.rst'])
    ]
    root = os.path.dirname(os.path.abspath(__file__))
    data_files = []
    for dirname, files in files_spec:
        resfiles = []
        for fn in files:
            if not os.path.exists(fn):
                warnings.warn('Skipping file %s since it is not present. Type  make  to build all automatically generated files.' % fn)
            else:
                resfiles.append(fn)
        data_files.append((dirname, resfiles))

    params = {
        'data_files': data_files,
    }
    params['entry_points'] = {'console_scripts': ['litcm = litcm:main']}

# Get the package version
exec(compile(open('litcm/version.py').read(),
             'litcm/version.py', 'exec'))

setup(
    name = "litcm",
    version = __version__,
    description="Language Identification and Transliteration system for Indian Languages in Roman script code mixed with English",
    long_description = open('README.rst', 'rb').read().decode('utf8'),
    keywords = ['Language Identification', 'Language Transliteration', 'WX', 
                'Computational Linguistics', 'Indic', 'Code-Mixing'],
    author='Irshad Ahmad',
    author_email='irshad.bhat@research.iiit.ac.in',
    maintainer='Irshad Ahmad',
    maintainer_email='irshad.bhat@research.iiit.ac.in',
    license = "MIT",
    url="https://github.com/irshadbhat/litcm",
    package_dir={'litcm':'litcm'},
    packages=['litcm'],
    package_data={'litcm': ['blm_models/*.blm', 'decision_trees/*.json', 'extras/*.txt']},

    classifiers=[
        "Topic :: Text Processing :: Linguistic",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Development Status :: 4 - Beta", 
        "Environment :: Console",
        "Intended Audience :: Science/Research",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3.3",
        "Operating System :: Unix"
    ],

    **params
)

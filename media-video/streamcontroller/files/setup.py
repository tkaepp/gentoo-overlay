# setup.py file contents
from setuptools import setup


import os
from setuptools import setup

with open('requirements.txt') as f:
    required = f.read().splitlines()

setup(
    name = streamcontroller,
    packages=['streamcontroller'],
    package_dir={'': 'src'},
    install_requires=required
)

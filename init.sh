#!/bin/bash

set -e
set -y

sudo apt-get install vim
sudo apt-get install python3-pip
sudo apt-get install curl

# lang8
pip3 install langid

# nucle
sudo apt-get install python-pip

pip install setuptools==0.6c11
pip install nltk==2.0b7

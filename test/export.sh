#!/bin/bash
export PATH=/home/media/test/:$PATH
declare -x DISPLAY=":0.0"

python3 ./sample.py


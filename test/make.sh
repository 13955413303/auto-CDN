#!/bin/bash
declare -x http_proxy="http://child-prc.intel.com:913"
declare -x https_proxy="http://child-prc.intel.com:913"
declare -x DISPLAY=":0.0"

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*
apt-get -f install

apt-get install python3-pip

pip3 install selenium

pip3 install pyvirtualdisplay
apt-get install xvfb
apt  install xterm

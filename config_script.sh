#!/bin/bash

cd programaton-config

CONFIG_DIR=$(pwd)
echo 'CONFIG dir'
echo $CONFIG_DIR

SED_USER=$(whoami)
echo 'SED user:'
echo $SED_USER

{ command -v spyder && SPYDER_BIN=$(command -v spyder); } || { command -v $HOME/.local/bin/spyder && SPYDER_BIN=$(command -v $HOME/.local/bin/spyder); } || { conda create --name ep && conda activate ep && conda install spyder -y && command -v spyder && SPYDER_BIN=$(command -v spyder); }

echo 'Spyder bin:'
echo $SPYDER_BIN

{ cd $HOME/Desktop && SED_DESKTOP='Desktop'; } || { cd $HOME/Escritorio && SED_DESKTOP='Escritorio'; }

echo 'SED Desktop'
echo $SED_DESKTOP

command -v python3 && SED_PYTHON=$(command -v python3)
echo 'SED Python3'
echo $SED_PYTHON

rm -rf programaton ; mkdir programaton ; cd programaton

touch programaton.py

CSS_PATH=$(cat $HOME/.config/spyder-py3/config/spyder.ini | grep css | awk '{ print $3 }')
echo 'CSS PATH'
echo $SED_CSS

sed "s,SED_USER,$SED_USER, ; s,SED_DESKTOP,$SED_DESKTOP, ; s,SED_CSS,$SED_CSS, ; s,SED_PYTHON,$SED_PYTHON," $CONFIG_DIR/spyder_input.ini > $CONFIG_DIR/spyder_output.ini
sed "s,SED_USER,$SED_USER, ; s,SED_DESKTOP,$SED_DESKTOP, ; s,SED_CSS,$SED_CSS, ; s,SED_PYTHON,$SED_PYTHON," $CONFIG_DIR/transient_input.ini > $CONFIG_DIR/transient_output.ini

cp $CONFIG_DIR/transient_output.ini $HOME/.config/spyder-py3/config/transient.ini
cp $CONFIG_DIR/spyder_output.ini $HOME/.config/spyder-py3/config/spyder.ini


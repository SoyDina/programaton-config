#!/bin/bash

CONFIG_DIR=$(pwd)
echo $CONFIG_DIR
SED_USER=$(whoami)
echo $SED_USER
{ type spyder && SED_SPYDER=$(type spyder); } || { type $HOME/.local/bin/spyder && SED_SPYDER='.local/bin/spyder'; }
echo $SED_SPYDER

{ cd $HOME/Desktop && SED_DESKTOP='Desktop'; } || { cd $HOME/Escritorio && SED_DESKTOP='Escritorio'; }

echo $SED_DESKTOP

rm -rf programaton ; mkdir programaton ; cd programaton

touch programaton.py

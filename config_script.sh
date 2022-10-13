#!/bin/bash

## GUARDA EL DIRECTORIO DEL REPO ##
CONFIG_DIR=$(pwd)
echo 'CONFIG dir'
echo $CONFIG_DIR

[ -d $HOME/.config/spyder-py3 ] || { cp $CONFIG_DIR/spyder-py3 $HOME/.config/ -r && echo 'Spyder config copiada'; }

## GUARDA EL USER ##
SED_USER=$(whoami)
echo 'SED user:'
echo $SED_USER

## Busca binario de spyder, si no, crea un environment con conda y lo instala ##
{ command -v spyder && SPYDER_BIN=$(command -v spyder); } || { command -v $HOME/.local/bin/spyder && SPYDER_BIN=$(command -v $HOME/.local/bin/spyder); } || { conda create --name ep && conda activate ep && conda install spyder -y && command -v spyder && SPYDER_BIN=$(command -v spyder); }
echo 'Spyder bin:'
echo $SPYDER_BIN

## Se fija si el escritorio se escribe como Desktop o Escritorio, hace cd ahí y lo guarda ##
{ cd $HOME/Desktop && SED_DESKTOP='Desktop'; } || { cd $HOME/Escritorio && SED_DESKTOP='Escritorio'; }
echo 'SED Desktop'
echo $SED_DESKTOP

## Busca el binario de python ##
command -v python3 && SED_PYTHON=$(command -v python3)
echo 'SED Python3'
echo $SED_PYTHON

## Elimina la carpeta programaton si ya existía y crea programaton.py ##
rm -rf programaton ; mkdir programaton ; cd programaton

## Se fija el path del css del spyder ##
SED_CSS=$(cat $HOME/.config/spyder-py3/config/spyder.ini | grep css | awk '{ print $3 }')
echo 'CSS PATH'
echo $SED_CSS

## Reemplaza los placeholders en los archivos de configuración de spyder .ini con los valores correctos ##
sed "s,SED_USER,$SED_USER, ; s,SED_DESKTOP,$SED_DESKTOP, ; s,SED_CSS,$SED_CSS, ; s,SED_PYTHON,$SED_PYTHON," $CONFIG_DIR/spyder_input.ini > $CONFIG_DIR/spyder_output.ini
sed "s,SED_USER,$SED_USER, ; s,SED_DESKTOP,$SED_DESKTOP, ; s,SED_CSS,$SED_CSS, ; s,SED_PYTHON,$SED_PYTHON," $CONFIG_DIR/transient_input.ini > $CONFIG_DIR/transient_output.ini

## Copia los nuevos archivos de configuración al path de configuarción del spyder ##
cp $CONFIG_DIR/transient_output.ini $HOME/.config/spyder-py3/config/transient.ini
cp $CONFIG_DIR/spyder_output.ini $HOME/.config/spyder-py3/config/spyder.ini

## Crea el ejecutable para encontrarlo entre las apps ##
sed -i "s,SPYDER_BIN,$SPYDER_BIN," $CONFIG_DIR/exec_spyder.sh
chmod +x $CONFIG_DIR/exec_spyder.sh
sed "s,SPYDER_BASH,$CONFIG_DIR/exec_spyder.sh, ; s,CONFIG_DIR,$CONFIG_DIR," $CONFIG_DIR/Spyder_input.desktop > $CONFIG_DIR/Spyder_output.desktop
chmod +x $CONFIG_DIR/Spyder_output.desktop
cp $CONFIG_DIR/Spyder_output.desktop $HOME/.local/share/applications/Spyder.desktop

cp $CONFIG_DIR/programaton/* ./

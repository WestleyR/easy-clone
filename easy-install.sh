#!/bin/sh
# Created by: Westley K
# email: westley@sylabs.io
# Date: Sep 3, 2018
# version-1.0.0
# https://github.com/WestleyK/easy-clone
#
# MIT License
#

set -e

SCRIPT_NAME="hubget"
INSTALL_PATH="/usr/local/bin/"

echo "Install script version: version-1.0.0"
echo 

WHERE=` pwd `
cd ~/
echo "Downloading file..."
git clone https://github.com/WestleyK/easy-clone.git
cd ~/easy-clone
chmod +x $SCRIPT_NAME
cd $WHERE
cp -f ${HOME}/easy-clone/$SCRIPT_NAME .

IS_SOURCE=` cat ${HOME}/.bashrc `

if [ "$IS_SOURCE" != *"easy-clone/auto-complete.sh"* ]; then
    echo "Adding source ${HOME}/easy-clone/auto-complete.sh to ${HOME}/.bashrc"
    if [ ! -w "${HOME}/.bashrc" ]; then
        echo "Need 'sudo' for '~/.bashrc'"    
        sudo sh -c 'echo "source ${HOME}/easy-clone/auto-complete.sh" >> ${HOME}/.bashrc'
    else
        echo "source ${HOME}/easy-clone/auto-complete.sh" >> ${HOME}/.bashrc
    fi
fi

echo 
echo
echo
echo "SUCCESS: install successful."
echo 
echo "########## $SCRIPT_NAME installed to the current directory  ##########"
echo
echo ">> To finish the install, do:"
echo " $ sudo mv $SCRIPT_NAME /usr/local/bin/"
echo " $ source ~/.bashrc"
exit 0

#
# End install script
#

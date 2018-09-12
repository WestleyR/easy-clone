#!/bin/bash
# created by: WestleyK
# date: Sep 12, 2018
# version-1.0.0
# https://github.com/WestleyK/easy-clone
#
# MIT Licence
#

#set -e

SCRIPT_NAME="hubget"

FUNC_DIR="${HOME}/.functions"
FUNC_FILE="${FUNC_DIR}/func-hubget.sh"

echo " Checking if in ${HOME}"
WHERE=` pwd `
if [[ "$WHERE" != "${HOME}/easy-clone"* ]]; then
    echo "ERROR: easy-clone not in: ${HOME}/"
    echo " > easy-clone must be in your home directory!"
    echo " > your home directory: ${HOME}/"
    exit 1
fi
echo " > working directory: ${HOME}/"

echo " Checking $SCRIPT_NAME exist"
if [ ! -f ../$SCRIPT_NAME ]; then
    echo "FATAL ERROR: main script dose not exist!"
    echo " > re-downloading the repo and try again"
    exit 1
fi
echo " > done."

echo " Checking and makeing: $FUNC_DIR"
if [ ! -d $FUNC_DIR ]; then
    echo " > Making: ${FUNC_DIR}"
    mkdir ${FUNC_DIR}
fi
echo " > done."

echo " Adding functions to: ${FUNC_FILE}"
touch $FUNC_FILE

cat <<_FILE > $FUNC_FILE
#!/bin/bash

hubget() {

    ~/easy-clone/./hubget $1 $2 $3

}

_FILE
chmod +x $FUNC_FILE
echo " > done."

echo " Adding/checking source to: ~/.bashrc"
IS_FILE=` cat ~/.bashrc | grep $FUNC_FILE `
if [[ -z $IS_FILE ]]; then
    echo " > adding source to: ~/.bashrc"
    echo "source $FUNC_FILE" >> ~/.bashrc
fi
IS_FILE=` cat ~/.bashrc | grep "auto-complete.sh" `
if [[ -z $IS_FILE ]]; then
    echo " > adding source for: auto-complete.sh to: ~/.bashrc"
    echo "source ${HOME}/easy-clone/auto-complete.sh" >> ~/.bashrc
fi
echo " > done."

cat <<_SUSC

########## INSTALL SECCESSFUL ##########

To finish the install, do
 >> $ source ~/.bashrc
_SUSC

exit 0

#
# End install.sh
#

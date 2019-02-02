#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# version-1.0.4
# Date: Feb 2, 2018
# https://github.com/WestleyK/easy-clone
#
# The Clear BSD License
#
# Copyright (c) 2018 WestleyK
# All rights reserved.
#
# This software is licensed under a Clear BSD License.
#

set -e

HOME_FILE="home-dir.txt"
DEP="dependencies"
SCRIPT_NAME="hubget"
INSTALL_TO="/usr/local/bin"

STRCOMP_URL="https://github.com/WestleyR/str/raw/master/pre-compiled/x86_64/strcomp"
ECGO_URL="https://github.com/WestleyK/ecgo/raw/master/pre-compiled/ubuntu-x86_64/ecgo"

USERNAME=""

help_usage() {
    ecgo -a "USAGE:
    ./install.sh [--user=username] [--prefix=/where/to/install]
                 [uninstall/remove, update]

DERSCTIPTION:
    simple install script for: ${SCRIPT_NAME}.

INFO:
    defalt installation  : ${INSTALL_TO}/${SCRIPT_NAME}

source code: https://github.com/WestleyK/easy-clone"

    exit 0
}

if [ ! -e "$DEP" ]; then
    mkdir "$DEP"
fi

if ! [ -x "$(command -v ecgo)" ]; then
    echo "ERROR: Need 'echo'"
    echo
    echo "This will automaticly download the precompiled code from github."
    echo
    echo "For install instrunctions, visit:"
    echo "https://github.com/WestleyK/ecgo"
    echo
    wget -O "$DEP/ecgo" "$ECGO_URL"
    chmod +x "$DEP/ecgo"
    cp "$DEP/ecgo" "/usr/bin"
    ecgo --info "'ecgo' Installed!" -l
fi

if ! [ -x "$(command -v strcomp)" ]; then
    ecgo -error "Need 'strcomp'" -l
    ecgo "This will automaticly download the precompiled code from github." -l
    ecgo "For install instrunctions, visit:" -l "https://github.com/WestleyR/strcomp" -l
    wget -O "$DEP/strcomp" "$STRCOMP_URL"
    chmod +x "$DEP/strcomp"
    cp "$DEP/strcomp" "/usr/bin"
    ecgo --info "'strcomp' Installed!" -l
fi

uninstall_script() {
    ecgo --warning "Uninstalling: ${SCRIPT_NAME}"
    if [ ! -f "${INSTALL_TO}/${SCRIPT_NAME}" ]; then
        ecgo -l --warning "Uninstall: ${SCRIPT_NAME}: Not in default install location."
        SCRIPT_LOCATION=` which ${SCRIPT_NAME} `
        ecgo --info "Uninstall: ${SCRIPT_NAME}: In: ${SCRIPT_LOCATION}"
        if [ ! -w "$SCRIPT_LOCATION" ]; then
            ecgo -l --fatal "Directory NOT writable: ${SCRIPT_LOCATION}."
            ecgo --fatal "Uninstall failed." -l
            ecgo "Try with \`sudo'"
            exit 255
        fi
        rm -f "${SCRIPT_LOCATION}${SCRIPT_NAME}"
    else
        ecgo --info "Uninstall: ${SCRIPT_NAME}: In: ${INSTALL_TO}"
        ecgo --warning "Uninstalling: ${SCRIPT_NAME}: From: ${INSTALL_TO}"
        if [ ! -w "$INSTALL_TO" ]; then
            ecgo -l --fatal "Directory NOT writable: ${INSTALL_TO}."
            ecgo --fatal "Uninstall failed." -l
            ecgo "Try with \`sudo'"
            exit 255
        fi
        rm -f "${INSTALL_TO}${SCRIPT_NAME}"
    fi
#    ecgo --info "Removing auto-complete.sh from ~/.bashrc..."
    IS_SOURCE=false
    if [[ ! -z $( cat "${HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
        ecgo -l -bold -negative --warning -yellow -negative "You should remove the following line from: " -bold "${HOME}/.bashrc:"
        ecgo "$(cat ${HOME}/.bashrc | grep "source /home/westleyk/*easy-clone/auto-complete.sh" )" -l
        IS_SOURCE=true


##        sed -i '' "/source\ \/home\/westleyk\/*easy-clone\/auto-complete.sh/d" $file
#        sed -ie '/source\ \/home\/westleyk\/*easy-clone\/auto-complete.sh/d' ~/foo
#        cat ${HOME}/.bashrc | grep -v "source /home/westleyk/*easy-clone/auto-complete.sh" >> ${HOME}/foo
#        ecgo "Removed source."
#    else
#        ecgo --info "No source to remove."
    fi    
    ecgo -l --info "Uninstall: SUCCESSFULL!"
    if [ "$IS_SOURCE" = true ]; then
        ecgo -green "DONE. " -r -teal -bold "And remenber to remove the source line from your .bashrc" -l
    else
        ecgo -green "DONE." -l
    fi

    exit 0
}

check_args() {
    OPTION="$1"
    if [[ $(ecgo -a "$OPTION" | strcomp -s="--user=") = 0 ]]; then
        USERNAME=` ecgo -a "$OPTION" | strcomp --cut-start=7 `
        ecgo -d "USERNAME: ${USERNAME}"
    elif [[ $(ecgo -a "$OPTION" | strcomp -s="--username=") = 0 ]]; then
        USERNAME=` ecgo -a "$OPTION" | strcomp --cut-start=11 `
        ecgo -d "USERNAME: ${USERNAME}"
    elif [[ $(ecgo -a "$OPTION" | strcomp -s="--prefix=") = 0 ]]; then
        INSTALL_TO=` ecgo -a "$OPTION" | strcomp --cut-start=9 `
        ecgo -d "INSTALLTO: ${INSTALL_TO}"
    elif [[ "$OPTION" = "-h" ]] || [[ "$OPTION" = "--help" ]]; then
        help_usage
    elif [[ "$OPTION" = "uninstall" ]] || [[ "$OPTION" = "remove" ]]; then
        uninstall_script
    else
        ecgo --fatal "Install: ${OPTION}: Option not found."
        exit 1
    fi
}

for OPTION in "$@"; do
    check_args "$OPTION"
done

ecgo --info "Installing to: ${INSTALL_TO}"
ecgo -d "Home: $HOME"
ecgo --debug "CWD: $(pwd)"

if [ ! -z $USERNAME ]; then
    ecgo --info "Username set: $USERNAME"
    NEW_HOME=`ecgo -a "/home/${USERNAME}"`
    ecgo --debug "New home: ${NEW_HOME}"
    if [ ! -f "${NEW_HOME}/.bashrc" ]; then
        ecgo -l --fatal "Install: ${NEW_HOME}/.bashrc: File not found."
        ecgo "Wrong username maybe?" -l
        exit 255
    fi
    if [[ "$(pwd)" != "${NEW_HOME}/easy-clone" ]]; then
        ecgo -l --warning "Install: easy-clone: Not in home directory: ${NEW_HOME}."
        ecgo --warning "easy-clone should be in your home directory."
        ecgo "Recomend to reinstall: ${SCRIPT_NAME} in your home direstory" -l
    fi
    if [[ -z $( cat "${NEW_HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
        ecgo --info "Adding: source $(pwd)/auto-complete.sh to: ${NEW_HOME}/.bashrc"
        ecgo -a "source $(pwd)/auto-complete.sh" >> "${NEW_HOME}/.bashrc"
    fi
else
    if [[ "$(pwd)" != "${HOME}/easy-clone" ]]; then
        ecgo -l --fatal "Install failed."
        ecgo "Try running with '--username=your_username'" -l
        exit 100
    fi
fi

if [[ -z $(cat "${HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
    ecgo --info "Adding: source ${HOME}/easy-clone/auto-complete.sh to: ${HOME}/.bashrc"
    ecgo -a "source ${HOME}/easy-clone/auto-complete.sh" >> "${HOME}/.bashrc"
fi

if [ -e "${INSTALL_TO}/${SCRIPT_NAME}" ]; then
    ecgo --warning "Overriding existing ${SCRIPT_NAME} version..."
fi

ecgo --info "UID: ${UID}"

if [ $UID -ne 0 ]; then
    ecgo --warning "UID is not 0, try running it with \`sudo'"
fi

ecgo --info "Installing: ${SCRIPT_NAME} to: ${INSTALL_TO}..."

if [ ! -d "$INSTALL_TO" ]; then
    ecgo -l --fatal "Install: ${INSTALL_TO}: No such directory."
    exit 255
fi

if [ ! -w "$INSTALL_TO" ]; then
    ecgo -l --fatal "Directory NOT writable: ${INSTALL_TO}."
    ecgo --fatal "Install failed." -l
    exit 255
fi
ecgo --info "Directory writable: ${INSTALL_TO}."

cp -f "$SCRIPT_NAME" "$INSTALL_TO"

ecgo -i -green "DONE!"

ecgo -l -blue -bold "$SCRIPT_NAME" -r -yellow " Installed to: " -r -teal "${INSTALL_TO}"
ecgo -l -blue "To finish the install, do:"
ecgo -yellow -bold "$ " -r -yellow "source ~/.bashrc" -l



#
# End Install Script
#


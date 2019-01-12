#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# version-1.0.2
# Date: Jan 10, 2018
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
SCRIPT_NAME="hubget"
INSTALL_TO="/usr/local/bin"

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

    ecgo -l --info "Uninstall: SUCCESSFULL!"
    ecgo -green "DONE." -l

    exit 0
}

check_args() {
    OPTION="$1"
    if [[ $(ecgo -a "$OPTION" | strcomp -s "--user=") = "true" ]]; then
        USERNAME=` ecgo -a "$OPTION" | cut -c 8- `
    elif [[ $(ecgo -a "$OPTION" | strcomp -s "--username=") = "true" ]]; then
        USERNAME=` ecgo -a "$OPTION" | cut -c 12- `
    elif [[ $(ecgo -a "$OPTION" | strcomp -s "--prefix=") = "true" ]]; then
        INSTALL_TO=` ecgo -a "$OPTION" | cut -c 10- `
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

ecgo --info "Installing to: ${INSTALL_TO}."
ecgo -d "Home: $HOME"
ecgo --debug "CWD: $(pwd)"

if [ ! -z $USERNAME ]; then
    ecgo --info "Username set: $USERNAME"
    NEW_HOME=`ecgo -a "/home/${USERNAME}"`
    ecgo --debug "New home: ${NEW_HOME}."
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
        ecgo "Try running with \`--username=your_username'" -l
        exit 100
    fi
fi

if [[ -z $( cat "${HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
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


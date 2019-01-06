#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# version-1.0.0
# Date: Jan 5, 2018
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
    ecgo -a "Usage: ./install.sh [--user=username]"

    exit 0
}


check_args() {
    OPTION="$1"
    if [[ $(ecgo -a "$OPTION" | strcomp -s "--user=") = "true" ]]; then
        USERNAME=` ecgo -a "$OPTION" | cut -c 8- `
    elif [[ $(ecgo -a "$OPTION" | strcomp -s "--username=") = "true" ]]; then
        USERNAME=` ecgo -a "$OPTION" | cut -c 12- `
    elif [[ "$OPTION" = "-h" ]] || [[ "$OPTION" = "--help" ]]; then
        help_usage
    fi
}

for OPTION in "$@"; do
    check_args "$OPTION"
done

if [ ! -z $USERNAME ]; then
    ecgo --info "Username set: $USERNAME"
    ecgo -a "$USERNAME" > "$HOME_FILE"
    if [[ -z $( cat "${HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
        ecgo --info "Adding: source ${HOME}/easy-clone/auto-complete.sh to: ${HOME}/.bashrc"
        ecgo -a "source ${HOME}/easy-clone/auto-complete.sh" >> "${HOME}/.bashrc"
#        source $USR_HOME/.bashrc
    fi
#    source $HOME/.bashrc
fi

ecgo -d "Home: $HOME"

ecgo --debug "CWD: $(pwd)"

#ecgo -l "$(pwd) ${HOME}/easy-clone" -l
#ecgo

if [[ "$(pwd)" != "${HOME}/easy-clone" ]]; then
    ecgo
    ecgo --warning "Not in home directory!"
    ecgo --error "Current working directory is not in ${HOME}"
    ecgo --debug "PWD: $(pwd)"
    ecgo --fatal "Not in home directory! install failed"
    exit 255
fi

if [[ -z $( cat "${HOME}/.bashrc" | grep 'easy-clone/auto-complete.sh') ]]; then
    ecgo --info "Adding: source ${HOME}/easy-clone/auto-complete.sh to: ${HOME}/.bashrc"
    ecgo -a "source ${HOME}/easy-clone/auto-complete.sh" >> "${HOME}/.bashrc"
else
    ecgo --info "${HOME}/.bashrc is already ready for ${SCRIPT_NAME}"
fi

if [ -e "${INSTALL_TO}/${SCRIPT_NAME}" ]; then
    ecgo --warning "Overriding existing ${SCRIPT_NAME} version..."
fi

ecgo --debug "UID: ${UID}"

ecgo --info "Installing: ${SCRIPT_NAME} to: ${INSTALL_TO}..."
#cp -f "$SCRIPT_NAME" "$INSTALL_TO"


ecgo -i -green "DONE!"

ecgo -l -blue -bold "$SCRIPT_NAME" -r -yellow " Installed to ${INSTALL_TO}"




#
# End Install Script
#


#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# version-1.0.6
# Date: Nov 14, 2019
# https://github.com/WestleyK/easy-clone
#
# The Clear BSD License
#
# Copyright (c) 2018-2019 WestleyK
# All rights reserved.
#
# This software is licensed under a Clear BSD License.
#

set -e

TARGET="hubget"

URL_FILE="hubget-options"
COMPLETE_FILE="hubget-complete.sh"

PREFIX="${HOME}/"
COMPLETION_PREFIX=""

help_usage() {
  echo "Usage: ./install.sh [--prefix=/non/root/location]"

  exit 0
}

while getopts 'p:c:h' OPTION; do
  case "$OPTION" in
    h)
      help_usage
      ;;

    p)
      echo HU $OPTARG
      PREFIX="$OPTARG"
      ;;

    c)
      COMPLETION_PREFIX="$OPTARG"
      ;;

    ?)
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

echo "Installing to ${PREFIX}"

HUBGET_DIR="easy-clone"

mkdir -p ${PREFIX}/bin
mkdir -p ${PREFIX}/${HUBGET_DIR}/github-urls

if [ -z $COMPLETION_PREFIX ]; then
  BASHRC_FILE=""

  if test -f ~/.bashrc; then
    BASHRC_FILE=~/.bashrc
  elif test -f ~/.bash_profile; then
    BASHRC_FILE=~/.bash_profile
  elif test -f ~/.profile; then
    BASHRC_FILE=~/.profile
  else
    echo "E: cant file .bashrc, .bash_profile, or .profile."
    echo "Please enter your full path to your .bashrc (or equivalent):"
    read BASHRC_FILE
    if ! test -f $BASHRC_FILE; then
      echo "File ${BASHRC_FILE} not found!"
      exit 1
    fi
  fi

  echo "I: bashrc file: ${BASHRC_FILE}"

  if ! grep -q "${PREFIX}/${HUBGET_DIR}/${COMPLETE_FILE}" "$BASHRC_FILE"; then
    echo "I: adding complete file to ${BASHRC_FILE}..."
    cat << EOF >> ${BASHRC_FILE}

. ${PREFIX}/${HUBGET_DIR}/${COMPLETE_FILE}
export HUBGET_PREFIX="${PREFIX}"

EOF
  else
    echo "I: ${BASHRC_FILE} already has source file"
  fi
  cp -f ${COMPLETE_FILE} ${PREFIX}/${HUBGET_DIR}

else
  mkdir -p ${COMPLETION_PREFIX}
  cp -f ${COMPLETE_FILE} ${COMPLETION_PREFIX}
fi

cp -f ${URL_FILE} ${PREFIX}/${HUBGET_DIR}/github-urls

chmod 755 ${PREFIX}/${HUBGET_DIR}/github-urls
chmod 755 ${PREFIX}/${HUBGET_DIR}/github-urls/${URL_FILE}

#chown ${USER}:${USER} ${PREFIX}/${HUBGET_DIR}/github-urls
#chown ${USER}:${USER} ${PREFIX}/${HUBGET_DIR}/github-urls/${URL_FILE}

cp -f ${TARGET} ${PREFIX}/bin

echo "Done."

# vim: tabstop=2 shiftwidth=2 expandtab

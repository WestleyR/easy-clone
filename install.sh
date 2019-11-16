#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# version-1.0.8
# Date: Nov 15, 2019
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
ETC_DIR=""

SKIP_CHECK=0

print_usage() {
  echo "Usage: ./install.sh [--prefix /non/root/location]"
  echo "                    [--etc-dir /non/root/etc]"
  echo "                    [--skip-check]"
  echo ""
  echo "Options:"
  echo "  -p, --prefix /path/to/install        specify a prefix to install"
  echo "  -e, --etc-dir /path/to/non-root/etc  specify a non-root etc dir,"
  echo "                                       only used for brew"
  echo "  -s, --skip-check                     skip the shasum check"
  echo ""

  exit 0
}

while [[ $# -gt 0 ]]; do
  option="$1"
  case $option in
    -p|--prefix)
      PREFIX="$2"
      shift
      shift
      ;;
    -e|--etc-dir)
      ETC_DIR="$2"
      shift
      shift
      ;;
    -s|--skip-check)
      SKIP_CHECK=1
      shift
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "E: unknown argument: ${option}"
      exit 22
      ;;
  esac
done

if [ $SKIP_CHECK -eq 0 ]; then
  echo "I: checking shasum of hubget, hubget-complete.sh, and install.sh ..."
  sha_cmd=$(command -v sha256sum || command -v shasum)
  $sha_cmd -c checksum.sha256
  echo "PASS"
fi

HUBGET_DIR="easy-clone"

mkdir -p ${PREFIX}/bin
mkdir -p ${PREFIX}/${HUBGET_DIR}/github-urls

if [ -z $ETC_DIR ]; then
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

  cp -f ${URL_FILE} ${PREFIX}/${HUBGET_DIR}/github-urls

  chmod 755 ${PREFIX}/${HUBGET_DIR}/github-urls
  chmod 755 ${PREFIX}/${HUBGET_DIR}/github-urls/${URL_FILE}

else
  mkdir -p ${ETC_DIR}/bash_completion.d
  cp -f ${COMPLETE_FILE} ${ETC_DIR}/bash_completion.d

  if ! test -f ${ETC_DIR}/easy-clone/github-urls/${URL_FILE}; then
    mkdir -p ${ETC_DIR}/easy-clone/github-urls
    cp -f ${URL_FILE} ${ETC_DIR}/easy-clone/github-urls
  fi

  chmod 755 ${ETC_DIR}/easy-clone/github-urls
  chmod 755 ${ETC_DIR}/easy-clone/github-urls
fi

cp -f ${TARGET} ${PREFIX}/bin

echo "Done."

# vim: tabstop=2 shiftwidth=2 expandtab

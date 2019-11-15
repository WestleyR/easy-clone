#!/bin/bash
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# Date: Nov 14, 2019
# version-1.0.6
# https://github.com/WestleyK/easy-clone
#
# The Clear BSD License
#
# Copyright (c) 2018-2019 WestleyK
# All rights reserved.
#
# This software is licensed under a Clear BSD License.
#

_auto_complete() {
    OPTION=$(cat ${HUBGET_PREFIX}/easy-clone/github-urls/hubget-options)
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$OPTION" -- $cur) )
}
complete -F _auto_complete hubget

#
# End script
#

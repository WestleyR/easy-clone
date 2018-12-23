#!/bin/bash
#
# Created by: WestleyK
# Email: westleyk@nym.hush.com
# Date: Nov 30, 2018
# version-1.0.3
# https://github.com/WestleyK/easy-clone
#
# The Clear BSD License
#
# Copyright (c) 2018 WestleyK
# All rights reserved.
#
# This software is licensed under a Clear BSD License.
#

_auto_complete() {
	OPTION=$( cat ~/easy-clone/option-url.txt )
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$OPTION" -- $cur) )
}
complete -F _auto_complete hubget



#
# End script
#



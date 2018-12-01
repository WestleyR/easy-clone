#!/bin/bash
#
# Created by: Westley K
# email: westley@sylabs.io
# Date: Nov 30, 2018
# version-1.0.4
#
# The Clear BSD License
#
# Copyright (c) 2018 WestleyK
# All rights reserved.
#
# This software is licensed under a Clear BSD License.
#

set -e

SCRIPT_NAME="hubget"
URL="https://raw.githubusercontent.com/WestleyK/easy-clone/master/hubget"
MAN_NAME="man/man1/hubget.1.gz"
MAN_URL="https://raw.githubusercontent.com/WestleyK/easy-clone/master/man/man1/hubget.1.gz"

echo "update script version: version-1.0.3"
echo "update script date: Nov 10, 2018"
echo


rm -f $SCRIPT_NAME
echo "Downloading script..."
curl $URL > $SCRIPT_NAME
chmod +x $SCRIPT_NAME
echo "Done."

echo "Downloading manpage..."
wget -O $MAN_NAME $MAN_URL

echo 
echo
echo
echo "SUCCESS: update successful."
echo 
echo "########## $SCRIPT_NAME is updated  ##########"
echo
echo ">> To finish the update, do:"
echo " $ sudo ./make.sh install"

exit 0



#
# End update.sh
#

#!/bin/bash
#
# Created by: Westley K
# email: westley@sylabs.io
# Date: Sep 5, 2018
# version-1.0.0
#
# MIT License
#
# Copyright (c) 2018 WestleyK
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

set -e

SCRIPT_NAME="hubget"
URL="https://raw.githubusercontent.com/WestleyK/easy-clone/master/hubget"

echo "update script version: version-1.0.0"
echo "update script date: Sep 5, 2018"
echo


rm -f $SCRIPT_NAME

curl $URL > $SCRIPT_NAME

echo 
echo
echo
echo "SUCCESS: update successful."
echo 
echo "########## $SCRIPT_NAME is updated  ##########"
echo
echo ">> To finish the update, do:"
echo " $ sudo mv $SCRIPT_NAME /usr/local/bin/"

exit 0



#
# End update.sh
#

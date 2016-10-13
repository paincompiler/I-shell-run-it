#!/usr/bin/env bash
# Created by paincompiler on 2016/10/09
# © 2016 PAINCOMPILER All RIGHTS RESERVED.

##########settings##########
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
set -o xtrace
##########settings##########

function finish {
    # cleanup code here
    echo "cleaning up"
}

trap finish EXIT

# script here
date=`date +%Y/%m/%d`
year=`date +%Y`
username=`whoami`
defaultfilename="${username}_new_python.py"
filedir="${1-$defaultfilename}"
printf "#!/usr/bin/env python\n\
# -*- coding: utf-8 -*-\n\
# © ${year} `echo ${username} | awk '{print toupper($0)}'` All RIGHTS RESERVED.\n\
__author__ = '${username}'\n\
__date__ = '${date}'\n" | cat -  > $filedir

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
printf "#!/usr/bin/env bash\n\
# Created by ${username} on ${date}\n\
# © ${year} `echo ${username} | awk '{print toupper($0)}'` All RIGHTS RESERVED.\n\n\
##########settings##########\n\
set -o errexit\n\
set -o errtrace\n\
set -o nounset\n\
set -o pipefail\n\
set -o xtrace\n\
##########settings##########\n\n\
function finish {\n\
    # cleanup code here\n\
    echo \"cleaning up\"\n\
}\n\n\
trap finish EXIT\n\n\
# script here\n" | cat -  > $1 
chmod 755 $1

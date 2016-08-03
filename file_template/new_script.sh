#!/usr/bin/env bash
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
##########settings##########\n" | cat -  > $1 
chmod 755 $1

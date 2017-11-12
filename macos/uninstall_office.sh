#!/usr/bin/env bash
# Created by paincompiler on 2017/11/12
# © 2017 PAINCOMPILER All RIGHTS RESERVED.

##########settings##########
# set -o errexit
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

# create temporary folder to hold the files to remove
if [ ! -d ~/.office-to-remove ]; then
    mkdir ~/.office-to-remove
fi 

# move Microsoft Applications into temporary folder
sudo mv /Applications/Microsoft* ~/.office-to-remove

# move Microsoft libs into temporary folder
sudo mv ~/Library/Containers/com.microsoft* ~/.office-to-remove
sudo mv ~/Library/Group\ Containers/UBF8T346G9* ~/.office-to-remove

# prompt for the confirmation
echo $(ls ~/.office-to-remove)
read -p "Remove all the files above?Y/N " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo rm -rf ~/.office-to-remove
    echo "Done removal!"
else
    # recover!
    sudo mv ~/.office-to-remove/Microsoft* /Applications/
    sudo mv ~/.office-to-remove/com.microsoft* ~/Library/Containers/ 
    sudo mv ~/.office-to-remove/UBF8T346G9* ~/Library/Group\ Containers/ 
    echo "All files recovered!"
fi

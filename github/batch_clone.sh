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
curl \
    -u ${GITHUB_ACCESS_KEY}:x-oauth-basic \
    -s https://api.github.com/${BATCH_TYPE}/${BATCH_NAME}/repos\?per_page\=100 \
    | python -c $'import json, sys, os\nfor repo in json.load(sys.stdin): print repo;os.system("git clone " + repo["ssh_url"])'

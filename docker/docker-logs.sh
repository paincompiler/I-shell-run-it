#!/usr/bin/env bash
# Created by paincompiler on 2016/11/01
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
	echo
	echo "Stopping tails $(jobs -p | tr '\n' ' ')"
	echo "..."

	jobs -p | tr '\n' ' ' | xargs -I % sh -c "kill % || true"

	echo "Done"
}

trap finish EXIT

# script here
names=$(docker ps --format "{{.Names}}")
echo "tailing $names"

while read -r name
do
  eval "docker logs -f --tail=500 \"$name\" |& sed -e \"s/^/[-- $name --] /\" &"
done <<< "$names"

# wait for ctr-c or tail exists 
wait

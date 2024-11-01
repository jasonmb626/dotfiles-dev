#!/bin/bash

while read id; do
    if [[ -z $id ]]; then
        continue;
    fi
    echo "Stopping task $id"
    task stop $id
done <<< $(task status:pending and +ACTIVE _uuids | grep -Pv '^\s*$')

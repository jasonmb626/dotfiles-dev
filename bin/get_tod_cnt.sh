#!/bin/bash

TOD_CNT=$(task status:pending +TOD count 2>/dev/null)
if [[ $TOD_CNT -gt 0 ]]; then
    echo "*$TOD_CNT*"
else
    echo "$TOD_CNT"
fi

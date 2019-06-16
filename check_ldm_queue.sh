#!/bin/bash

INFO=`/usr/bin/sudo /opt/ldm/bin/pqmon -S`

IFS=' ' read -ra ITEM <<< "${INFO}"

echo -e "age:${ITEM[7]}"

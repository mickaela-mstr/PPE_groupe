#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Ce programme demande un argument =  la langue."
    exit 1
fi

langue=$1

for file in ../dumps-text/$langue/$langue-*.txt; do
    perl -CSD -pe 's/[^\p{L}\p{M}\p{N}\p{Z}\.]+/\n/g' $file > ../pals/dumps-text/$langue.txt
done

for file in ../contextes/$langue/$langue-*.txt; do
    perl -CSD -pe 's/[^\p{L}\p{M}\p{N}\p{Z}\.]+/\n/g' $file > ../pals/contextes/$langue.txt
done

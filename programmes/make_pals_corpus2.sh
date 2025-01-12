#!/bin/bash

export LANG=C.UTF-8
export LC_ALL=C.UTF-8

if [ $# -ne 1 ]; then
    echo "Ce programme demande un argument : un argument pour la langue"
    exit 1
fi

langue=$1

if [ "$langue" == "arabe" ]; then
    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g" > ../pals/cooccurrent/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g" > ../pals/cooccurrent/contextes/$langue.txt
        done
fi

if [ "$langue" == "francais" ]; then
    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "a-zàâçéèêëîïôûùüÿñæœ" "\n" | sed "s/\./\n/g"  > ../pals/cooccurrent/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "a-zàâçéèêëîïôûùüÿñæœ" "\n" | sed "s/\./\n/g" > ../pals/cooccurrent/contextes/$langue.txt
        done
fi

if [ "$langue" == "anglais" ]; then

    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g"  > ../pals/cooccurrent/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" > ../pals/cooccurrent/contextes/$langue.txt
        done
fi


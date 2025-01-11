#!/bin/bash

export LANG=C.UTF-8 #merci kehina
export LC_ALL=C.UTF-8

if [ $# -ne 1 ] #verifier si le script a un argument
then
    echo "ce programme demande un argument: un argument pour la langue"
fi

langue=$1

if [ "$langue" == "arabe" ]; then
    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g"  > ../pals/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g" > ../pals/contextes/$langue.txt
        done
fi

if [ "$langue" == "francais" ]; then
    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "a-zàâçéèêëîïôûùüÿñæœ" "\n" | sed "s/\./\n/g"  > ../pals/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "a-zàâçéèêëîïôûùüÿñæœ" "\n" | sed "s/\./\n/g" > ../pals/contextes/$langue.txt
        done
fi

if [ "$langue" == "anglais" ]; then

    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g"  > ../pals/dumps-text/$langue.txt
        done

    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" > ../pals/contextes/$langue.txt
        done
fi

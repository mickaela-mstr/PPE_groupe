#!/bin/bash

if [ $# -ne 1 ] #verifier si le script a un argument
then
	echo "ce programme demande un argument: un argument pour le chemin vers le dossier et la langue"
fi

langue=$1

if [ "$langue" == "arabe" ]; then
    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g"  > ../pals/dumps-text/$langue.txt
        done
    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "ا-ي." "\n" | sed "s/\./\n/g" > ../pals/contextes/$langue.txt
        done
else

    for file in "../dumps-text/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g"  > ../pals/dumps-text/$langue.txt
        done

    for file in "../contextes/$langue/$langue-*.txt"; do
        cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" > ../pals/contextes/$langue.txt
        done
fi

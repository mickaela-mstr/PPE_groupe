#!/bin/bash

if [ $# -ne 2 ] #verifier si le script a un argument
then
	echo "ce programme demande deux arguments: un argument pour le chemin vers le dossier et la langue"
fi

dossier=$1
langue=$2
for file in "../$dossier/$langue/$langue-*.txt"; do
    cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g"  > ../pals2/dumps-text/$langue
done

for file in "../contextes/$langue/$langue-*.txt"; do
    cat $file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" > ../pals2/contextes/$langue
done

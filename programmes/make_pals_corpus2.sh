#!/bin/bash

export LANG=C.UTF-8
export LC_ALL=C.UTF-8

if [ $# -ne 1 ]; then
    echo "Ce programme demande un argument : un argument pour la langue"
    exit 1
fi

langue=$1

if [ "$langue" == "arabe" ]; then
    # Pour les fichiers dumps-text
    for file in ../pals/dumps-text/$langue*.txt; do
        cat "$file" | tr -cs '\u0600-\u06FF' '\n' | sed "s/\./\n/g" >> "../pals/cooccurrent/dumps-text/arabe.txt"
    done
    # Pour les fichiers contextes
    for file in ../pals/contextes/$langue*.txt; do
        cat "$file" | tr -cs '\u0600-\u06FF' '\n' | sed "s/\./\n/g" >> "../pals/cooccurrent/contextes/arabe.txt"
    done
fi

if [ "$langue" == "francais" ]; then
    for file in ../pals/dumps-text/$langue*.txt; do
        cat "$file" | tr -cs "a-zàâçéèêëîïôûùüÿñæœ." "\n" | sed "s/\./\n/g" >> "../pals/cooccurrent/dumps-text/francais.txt"
    done
    for file in ../pals/contextes/$langue*.txt; do
        cat "$file" | tr -cs "a-zàâçéèêëîïôûùüÿñæœ." "\n" | sed "s/\./\n/g" >> "../pals/cooccurrent/contextes/francais.txt"
    done
fi

if [ "$langue" == "anglais" ]; then
    for file in ../pals/dumps-text/$langue*.txt; do
        cat "$file" | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" >> "../pals/cooccurrent/dumps-text/anglais.txt"
    done
    for file in ../pals/contextes/$langue*.txt; do
        cat "$file" | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" >> "../pals/cooccurrent/contextes/anglais.txt"
    done
fi


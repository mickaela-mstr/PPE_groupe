#!/bin/bash

BASE_DIR=".."
EN_CONTEXT_DIR="$BASE_DIR/contextes/anglais"
EN_DUMPS_DIR="$BASE_DIR/dumps-text/anglais"
PALS_DIR="$BASE_DIR/pals"

input_folder=$1
base_name=$2

process_file() {
    input_file=$1
    output_file=$2

    cat $input_file | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g" > "$output_file"
}

if [[ $input_folder == "dumps-text" ]]; then
    input_folder=$EN_DUMPS_DIR
elif [[ $input_folder == "contextes" ]]; then
    input_folder=$EN_CONTEXT_DIR
else
    echo "Dossier non reconnu."
    exit 1
fi


if [[ ! -d $input_folder ]]; then
    echo "Erreur : Le dossier $input_folder n'existe pas."
    exit 1
fi

if [[ -z $(ls "$input_folder"/*.txt 2>/dev/null) ]]; then
    echo "Erreur : Aucun fichier .txt trouvé dans $input_folder."
    exit 1
fi

for file in "$input_folder"/*.txt; do
    filename=$(basename "$file" .txt)  # Nom du fichier sans extension
    output_file="$PALS_DIR/${base_name}-${filename}.txt"
    process_file "$file" "$output_file"
done

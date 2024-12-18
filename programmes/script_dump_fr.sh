#!/usr/bin/env bash

fichier="../URLs/français.txt"

# Fichier de sortie pour le dump textuel
output_file="../dumps-text/français.txt"

# Vider ou créer le fichier de sortie
> "$output_file"

# Lire le fichier ligne par ligne
while read -r line; do
    # Ajouter un séparateur entre les dumps des différentes URLs (optionnel)
    echo "=== URL: $line ===" >> "$output_file"
    # Récupérer le contenu textuel de l'URL et l'ajouter au fichier de sortie
    lynx -dump -nolist "$line" >> "$output_file"
    echo -e "\n" >> "$output_file" # Ajouter une ligne vide entre les dumps
done < "$fichier"

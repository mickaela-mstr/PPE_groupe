#!/usr/bin/env bash

fichier="../URLs/français.txt"

# Fichier de sortie pour l'aspiration
output_file="../aspirations/français.html"

# Vider ou créer le fichier de sortie
> "$output_file"

# Début du fichier HTML
echo "<!DOCTYPE html>" > "$output_file"
echo "<html lang='fr'>" >> "$output_file"
echo "<head><meta charset='UTF-8'><title>Aspirations</title></head>" >> "$output_file"
echo "<body>" >> "$output_file"
echo "<h1>Pages Aspirées</h1>" >> "$output_file"

# Lire le fichier ligne par ligne
while read -r line; do
    # Ajouter un en-tête pour chaque URL
    echo "<h2>URL: $line</h2>" >> "$output_file"
    # Télécharger le contenu de l'URL et l'ajouter dans un bloc HTML
    echo "<div class='aspiration'>" >> "$output_file"
    curl -s "$line" >> "$output_file"
    echo "</div><hr>" >> "$output_file"
done < "$fichier"

# Fin du fichier HTML
echo "</body>" >> "$output_file"
echo "</html>" >> "$output_file"

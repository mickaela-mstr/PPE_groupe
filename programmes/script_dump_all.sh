#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    fichier="../URLs/${langue}.txt"
    output_file="../dumps-text/${langue}.txt"
        while read -r line; do
            echo "=== URL: $line ===" >> "$output_file"
            lynx -dump -nolist "$line" >> "$output_file"
            echo -e "\n" >> "$output_file" # Ajouter une ligne vide entre les dumps
        done < "$fichier"
done

echo "Traitement terminé pour toutes les langues."

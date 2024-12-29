#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    fichier="../URLs/${langue}.txt"
    output_file="../aspirations/${langue}.html"
        echo "<!DOCTYPE html>" > "$output_file"
        echo "<html lang='fr'>" >> "$output_file"
        echo "<head><meta charset='UTF-8'><title>Aspirations - ${langue}</title></head>" >> "$output_file"
        echo "<body>" >> "$output_file"
        echo "<h1>Pages Aspirées - ${langue}</h1>" >> "$output_file"
        while read -r line; do
            echo "<h2>URL: $line</h2>" >> "$output_file"
            echo "<div class='aspiration'>" >> "$output_file"
            curl -s "$line" >> "$output_file"
            echo "</div><hr>" >> "$output_file"
        done < "$fichier"
        echo "</body>" >> "$output_file"
        echo "</html>" >> "$output_file"
done

echo "Traitement terminé pour toutes les langues."

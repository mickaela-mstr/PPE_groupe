#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    fichier="../URLs/${langue}.txt"
    output_dir="../aspirations/${langue}"

    index=1
    while read -r line; do
        output_file="${output_dir}/${langue}-${index}.html"

        echo "<!DOCTYPE html>" > "$output_file"
        echo "<html lang='fr'>" >> "$output_file"
        echo "<head><meta charset='UTF-8'><title>Page Aspirée - ${langue}-${index}</title></head>" >> "$output_file"
        echo "<body>" >> "$output_file"
        echo "<h1>URL : $line</h1>" >> "$output_file"
        echo "<div class='aspiration'>" >> "$output_file"
        curl -s "$line" >> "$output_file"
        echo "</div>" >> "$output_file"
        echo "</body>" >> "$output_file"
        echo "</html>" >> "$output_file"
        index=$((index + 1))
    done < "$fichier"
done

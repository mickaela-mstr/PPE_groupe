#!/bin/bash

dossier_dumps="../dumps-text"
dossier_concordances="../concordances"

langues=("anglais" "arabe" "français")
mot="légende"

for langue in "${langues[@]}"; do
    input_file="$dossier_dumps/$langue.txt"
    output_file="$dossier_concordances/$langue.html"

    if [[ ! -f "$input_file" ]]; then
        echo "Le fichier source pour $langue est introuvable : $input_file"
        continue
    fi

    echo "<html>" > "$output_file"
    echo "<body>" >> "$output_file"
    echo "<table border='1'>" >> "$output_file"
    echo "<tr><th>Contexte gauche</th><th>Mot</th><th>Contexte droit</th></tr>" >> "$output_file"

    grep -o ".\{0,30\}$mot.\{0,30\}" "$input_file" | while read -r line; do
        gauche=$(echo "$line" | sed -E "s/(.*)$mot.*/\1/")
        droite=$(echo "$line" | sed -E "s/.*$mot(.*)/\1/")
        echo "<tr><td>$gauche</td><td>$mot</td><td>$droite</td></tr>" >> "$output_file"
    done

    echo "</table>" >> "$output_file"
    echo "</body>" >> "$output_file"
    echo "</html>" >> "$output_file"

    echo "Concordancier pour $langue généré dans $output_file"
done

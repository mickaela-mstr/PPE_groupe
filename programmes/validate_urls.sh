#!/bin/bash

URLS_DIR="../URLs"
TABLEAUX_DIR="../tableaux"

for urls_file in "$URLS_DIR"/*.txt; do
    language=$(basename "$urls_file" .txt)
    output_table="$TABLEAUX_DIR/${language}.html

    echo "<html><body><table border='1'>" > "$output_table"
    echo "<tr><th>URL</th><th>Statut</th></tr>" >> "$output_table"

    while IFS= read -r url; do
        if [[ -z "$url" ]]; then
            continue
        fi
        status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")

        if [[ $status_code -ge 200 && $status_code -lt 300 ]]; then
            echo "URL valide : $url"
            echo "<tr><td>$url</td><td>Valide ($status_code)</td></tr>" >> "$output_table"
        else
            echo "URL invalide : $url" >&2
            echo "<tr><td>$url</td><td>Invalide ($status_code)</td></tr>" >> "$output_table"
        fi
    done < "$urls_file"

    echo "</table></body></html>" >> "$output_table"
    echo "Tableau généré : $output_table"
done

echo "Tous les tableaux ont été mis à jour dans le dossier"


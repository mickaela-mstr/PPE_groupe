#!/usr/bin/env bash

declare -A mots_etudies
mots_etudies=(
    ["anglais"]="legend"
    ["francais"]="légende"
    ["arabe"]="أسطورة"
)

langues=("anglais" "francais" "arabe")

dump_folder="../dumps-text"
aspiration_folder="../aspirations"
contexte_folder="../contextes"
concordance_folder="../concordances"
tableau_folder="../tableaux"

for langue in "${langues[@]}"; do
    fichier="../URLs/${langue}.txt"
    sortie="${tableau_folder}/${langue}.html"
    mot_etudie="${mots_etudies[$langue]}"
    numero_ligne=1

    echo "📊 Génération du tableau pour la langue : $langue"

    echo "<html><body><table border='1'>" > "$sortie"
    echo "<tr>
            <th>Ligne</th>
            <th>URL</th>
            <th>Code HTTP</th>
            <th>Nombre de mots</th>
            <th>Encodage</th>
            <th>Aspirations</th>
            <th>Contextes</th>
            <th>Dumps Text</th>
            <th>Concordances</th>
          </tr>" >> "$sortie"

    while read -r line; do
        code_http=$(curl -o /dev/null -s -w "%{http_code}" "$line")
        encodage=$(curl -s -I --show-error "$line" | grep -i "content-type: text/html; charset=" | sed 's/.*charset=//I')
        nb_mots=$(curl -s --show-error "$line" | wc -w)
        aspiration_file="${aspiration_folder}/${langue}_$(echo "$line" | sed 's|https\?://||; s|/|_|g').html"
        contexte_file="${contexte_folder}/${langue}_$(echo "$line" | sed 's|https\?://||; s|/|_|g').txt"
        dump_file="${dump_folder}/${langue}_$(echo "$line" | sed 's|https\?://||; s|/|_|g').txt"
        concordance_file="${concordance_folder}/${langue}.html"
        aspirations="<a href='../${aspiration_file}'>Voir aspiration</a>"
        contextes="<a href='../${contexte_file}'>Voir contexte</a>"
        dumps_text="<a href='../${dump_file}'>Voir dump</a>"
        concordances="<a href='../${concordance_file}'>Voir concordance</a>"

        echo "<tr>
                <td>${numero_ligne}</td>
                <td>${line}</td>
                <td>${code_http}</td>
                <td>${nb_mots}</td>
                <td>${encodage}</td>
                <td>${aspirations}</td>
                <td>${contextes}</td>
                <td>${dumps_text}</td>
                <td>${concordances}</td>
              </tr>" >> "$sortie"

        numero_ligne=$((numero_ligne + 1))
    done < "$fichier"

    echo "</table></body></html>" >> "$sortie"
    echo "✅ Tableau généré : $sortie"
done

echo "🏁 Traitement terminé pour toutes les langues."

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

    echo "<html lang='fr'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Tableau pour la langue : $langue</title>
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma/css/bulma.min.css'>
    <style>
        body {
            background: linear-gradient(135deg, #fdfcfb, #e2d1c3);
            color: #4a4a4a;
            font-family: 'Georgia', serif;
        }
        h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #6b4226;
            text-align: center;
            margin-top: 20px;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #d4b59e;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f3c5b3;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .container {
            padding: 2rem;
        }
    </style>
</head>
<body>
    <h1>Tableau pour la langue : $langue</h1>
    <div class='container'>
        <table>
            <tr>
                <th>Ligne</th>
                <th>URL</th>
                <th>Code HTTP</th>
                <th>Nombre de mots</th>
                <th>Encodage</th>
                <th>Aspirations</th>
                <th>Contextes</th>
                <th>Dumps Text</th>
                <th>Concordances</th>
                <th>Compte</th>
            </tr>" > "$sortie"

    while read -r line; do
        code_http=$(curl -o /dev/null -s -w "%{http_code}" "$line")
        encodage=$(curl -s -I --show-error "$line" | grep -i "content-type: text/html; charset=" | sed 's/.*charset=//I')
        nb_mots=$(curl -s --show-error "$line" | wc -w)
        aspiration_file="${aspiration_folder}/${langue}/${langue}-${numero_ligne}.html"
        contexte_file="${contexte_folder}/${langue}/${langue}-${numero_ligne}.txt"
        dump_file="${dump_folder}/${langue}/${langue}-${numero_ligne}.txt"
        concordance_file="${concordance_folder}/${langue}/${langue}-${numero_ligne}.html"
        aspirations="<a href='${aspiration_file}'>Voir aspiration</a>"
        contextes="<a href='${contexte_file}'>Voir contexte</a>"
        dumps_text="<a href='${dump_file}'>Voir dump</a>"
        concordances="<a href='${concordance_file}'>Voir concordance</a>"
        compte=$(cat "${dump_file}" | egrep -a -o -i "${mot_etudie}" | wc -w)

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
                <td>${compte}</td>
              </tr>" >> "$sortie"

        numero_ligne=$((numero_ligne + 1))
    done < "$fichier"

    echo "</table></div></body></html>" >> "$sortie"
done

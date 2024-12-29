#!/usr/bin/env bash

fichier="../URLs/arabe.txt"
sortie="../tableaux/arabe.html"
dump_folder="../dumps-text"
aspiration_folder="../aspirations"
contexte_folder="../contextes"
numero_ligne=1

echo "<html><body><table border='1'>" > "$sortie"
echo "<tr><th>Ligne</th><th>URL</th><th>Code HTTP</th><th>Nombre de mots</th><th>Encodage</th><th>Aspirations</th><th>Contextes</th><th>Dumps Text</th></tr>" >> "$sortie"

while read -r line
  do
    code_http=$(curl -o /dev/null -s -w "%{http_code}" "$line")
    encodage=$(curl -s -I --show-error "$line" | grep -i "content-type: text/html; charset=")
    nb_mots=$(curl -s --show-error "$line" | wc -w)
    aspiration_file="${aspiration_folder}/$(echo "$line" | sed 's|https\?://||; s|/|_|g').html"
    aspirations="<a href='../${aspiration_file}'>Voir aspiration</a>"
    contexte_file="${contexte_folder}/$(echo "$line" | sed 's|https\?://||; s|/|_|g').txt"
    contextes="<a href='../${contexte_file}'>voir contexte</a>"
    dump_file="${dump_folder}/$(echo "$line" | sed 's|https\?://||; s|/|_|g').txt"
    dumps_text="<a href='../${dump_file}'>Voir dump</a>"
    echo "<tr><td>${numero_ligne}</td><td>${line}</td><td>${code_http}</td><td>${nb_mots}</td><td>${encodage}</td><td>${aspirations}</td><td>${contextes}</td><td>${dumps_text}</td></tr>" >> "$sortie"
    numero_ligne=$((numero_ligne + 1))
done < "$fichier"

echo "</table></body></html>" >> "$sortie"

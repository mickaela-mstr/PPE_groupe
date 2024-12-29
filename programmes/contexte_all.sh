#!/usr/bin/env bash

declare -A mots_etudies
mots_etudies=(
    ["anglais"]="legend"
    ["francais"]="légende"
    ["arabe"]="أسطورة"
)

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    input_file="../dumps-text/${langue}.txt"
    output_file="../contextes/${langue}.txt"
    mot_etudie="${mots_etudies[$langue]}"
        grep -a -i -w -C 1 "$mot_etudie" "$input_file" | sed "s/\b$mot_etudie\b/>>>$mot_etudie<<</Ig" > "$output_file"
done

echo "Traitement terminé pour toutes les langues."

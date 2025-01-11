#!/usr/bin/env bash

declare -A mots_etudies
mots_etudies=(
    ["anglais"]="\\blegends?\\b"
    ["francais"]="\\blégendes?\\b"
    ["arabe"]="\\b(أسطورة|أسطورات|أسطورتين|الأسطورة|الأسطورات|الأسطورتين)\\b"
)

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    input_dir="../dumps-text/${langue}"
    output_dir="../contextes/${langue}"
    mot_etudie="${mots_etudies[$langue]}"

    for fichier in "$input_dir"/*.txt; do
        base_name=$(basename "$fichier" .txt)
        output_file="${output_dir}/${base_name}.txt"
        egrep --binary-files=text -i -E -C 1 "$mot_etudie" "$fichier" | sed "s/\b$mot_etudie\b/>>>$mot_etudie<<</Ig" > "$output_file"
    done
done

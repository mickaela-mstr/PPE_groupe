#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    input_dir="../dumps-text/${langue}"
    output_dir="../contextes/${langue}"

    if [ "$langue" == "anglais" ]; then
        regex="\\b${mot_etudie}(s|es)?\\b"
    elif [ "$langue" == "francais" ]; then
        regex="\\b${mot_etudie}(s|es)?\\b"
    elif [ "$langue" == "arabe" ]; then
        regex="\\b(${mot_etudie}|أسطورات|أسطورتين|الأسطورة|الأسطورات|الأسطورتين)\\b"
    else
        echo "Langue inconnue : $langue"
        continue
    fi

    # Création du dossier de sortie
    mkdir -p "$output_dir"

    for fichier in "$input_dir"/*.txt; do
        base_name=$(basename "$fichier" .txt)
        output_file="${output_dir}/${base_name}.txt"

        # Recherche et mise en évidence avec grep et sed
        grep -a -i -w -C 1 -E "$regex" "$fichier" | sed -E "s/($regex)/>>>\1<</Ig" > "$output_file"
    done
done

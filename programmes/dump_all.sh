#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    fichier="../URLs/${langue}.txt"
    output_dir="../dumps-text/${langue}"

    index=1
    while read -r line; do
        dump_file="${output_dir}/${langue}-${index}.txt"
        lynx -dump -nolist "$line" > "$dump_file"
        index=$((index + 1))
    done < "$fichier"
done

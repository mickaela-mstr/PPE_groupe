#!/usr/bin/env bash

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    input_dir="../dumps-text/${langue}"
    output_dir="../contextes/${langue}"

    for fichier in "$input_dir"/*.txt; do
        base_name=$(basename "$fichier" .txt)
        output_file="${output_dir}/${base_name}.txt"

        if [ "$langue" == "anglais" ]; then
            for file in "${input_dir}/$langue-*.txt"; do
                egrep --binary-files=text -i -E -C 1 "\blegends?\b" ../dumps-text/anglais/anglais-*.txt | sed "s/\blegends?\b/>>>legends?<<</Ig" > "$output_file"
                done
        fi

        if [ "$langue" == "francais" ]; then
            for file in "${input_dir}/$langue/$langue-*.txt"; do
                egrep --binary-files=text -i -E -C 1 "\blégendes?\b" ../dumps-text/francais/francais-*.txt | sed "s/\blégendes?\b/>>>légendes?<<</Ig" > "$output_file"
                done
        fi

        if [ "$langue" == "arabe" ]; then
            for file in "${input_dir}/$langue/$langue-*.txt"; do
                egrep --binary-files=text -i -E -C 1 "\bأسطورة|أسطورات|أسطورتين|الأسطورة|الأسطورات|الأسطورتين\b" ../dumps-text/arabe/arabe-*.txt | sed "s/\bأسطورة\b/>>>أسطورة<<</Ig" > "$output_file"
                done
        fi
    done
done

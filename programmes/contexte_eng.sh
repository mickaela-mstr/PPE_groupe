#!/usr/bin/env bash

mot_etudie="legend"
input_file="../dumps-text/anglais.txt"
output_file="../contextes/anglais.txt"

grep -i -w -C 1 "$mot_etudie" "$input_file" | sed "s/\b$mot_etudie\b/>>>$mot_etudie<<</Ig" > "$output_file"




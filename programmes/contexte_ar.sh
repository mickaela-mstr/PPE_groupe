#!/usr/bin/env bash

mot_etudie="أسطورة"
input_file="../dumps-text/arabe.txt"
output_file="../contextes/arabe.txt"

grep -i -w -C 1 "$mot_etudie" "$input_file" | sed "s/\b$mot_etudie\b/>>>$mot_etudie<<</Ig" > "$output_file"




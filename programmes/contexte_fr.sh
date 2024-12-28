#!/usr/bin/env bash

mot_etudie="légende"
input_file="../dumps-text/français.txt"
output_file="../contextes/français.txt"

grep -i -w -C 1 "$mot_etudie" "$input_file" | sed "s/\b$mot_etudie\b/>>>$mot_etudie<<</Ig" >> "$output_file"




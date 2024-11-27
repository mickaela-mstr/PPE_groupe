#!/usr/bin/env bash

tableau_tsv=$1

echo "<html>" > "tableau-fr2.html"
echo "<head>" >> "tableau-fr2.html"
echo "<title>Tabelau-fr</title>" >> "tableau-fr2.html"
echo "<meta charset=UTF-8>" >> "tableau-fr2.html"
echo "</head>" >> "tableau-fr2.html"
echo "<body>" >> "tableau-fr2.html"
echo "<table>" >> "tableau-fr2.html"
echo "<tr>" >> "tableau-fr2.html"
echo "<th>index</th>" >> "tableau-fr2.html"
echo "<th>URL</th>" >> "tableau-fr2.html"
echo "<th>code HTTP</th>" >> "tableau-fr2.html"
echo "<th>nombre de mots</th>" >> "tableau-fr2.html"
echo "<th>encodage</th>" >> "tableau-fr2.html"
echo "</tr>" >> "tableau-fr2.html"

while IFS=$'\t' read -r -a line; do
    echo "        <tr>" >> "tableau-fr2.html"
    for cell in "${line[@]}"; do
            echo "            <td>$cell</td>" >> "tableau-fr2.html"
    done
    echo "        </tr>" >> "tableau-fr2.html"
done < $tableau_tsv

echo "    </table>" >> "tableau-fr2.html"
echo "</body>" >> "tableau-fr2.html"
echo "</html>" >> "tableau-fr2.html"

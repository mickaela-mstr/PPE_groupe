#!/bin/bash

# Variables
mot_etude="légende"
chemin_dossier="./dumps-text/"
chemin_tableau_html="./tableaux/"

# Ici on a une fonction pour compter les occurrences du mot dans un fichier
compter_occurrences() {
    local fichier="$1"
    local mot="$2"
    grep -o -i -w "$mot" "$fichier" | wc -l
}

# Fonction pour ajouter une colonne "Compte" dans le tableau HTML
ajouter_colonne_tableau() {
    local fichier_html="$1"
    local compte="$2"

    # Ensuite on vérifie si la colonne "Compte" existe déjà
    if ! grep -q "<th>Compte</th>" "$fichier_html"; then
        sed -i 's/<tr>/<tr><th>Compte<\/th>/' "$fichier_html"
    fi

    # Ajouter les valeurs de compte pour chaque ligne
    sed -i "s/<\/tr>/<td>${compte}<\/td><\/tr>/" "$fichier_html"
}

# Parcourir chaque fichier texte dans le dossier
for fichier in "$chemin_dossier"*.txt; do
    if [[ -f "$fichier" ]]; then
        langue=$(basename "$fichier" .txt)
        nb_occurrences=$(compter_occurrences "$fichier" "$mot_etude")

        # Enfin on Vérifie si un tableau HTML existe pour cette langue
        fichier_html="${chemin_tableau_html}${langue}.html"
        if [[ -f "$fichier_html" ]]; then
            ajouter_colonne_tableau "$fichier_html" "$nb_occurrences"
        fi
    fi
done

echo "Mise à jour des tableaux terminée."

#!/bin/bash

# Vérification des arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <type_fichier>"
    echo "Exemple: $0 dumps-text ou $0 contextes"
    exit 1
fi

# Argument : type de fichier à traiter (dumps-text ou contextes)
type_fichier="$1"

# Dossiers et langues
dossier_pals="pals"
dossier_source="$type_fichier"
langues=("arabe" "français" "anglais")

# Création du dossier pals s'il n'existe pas
mkdir -p "$dossier_pals"

# Boucle sur les langues
for langue in "${langues[@]}"; do
    fichier_source="$dossier_source/$langue.txt"
    fichier_sortie="$dossier_pals/${type_fichier}-${langue}.txt"

    echo "Traitement des fichiers $type_fichier pour la langue $langue..."

    # Vérification de l'existence du fichier source
    if [[ -f "$fichier_source" ]]; then
        echo "Traitement de $fichier_source..."
        # Prétraitement : suppression des caractères non alphanumériques, découpage en mots
        cat "$fichier_source" | sed 's/[^[:alnum:] ]//g' | tr ' ' '\n' | sed '/^$/d' > "$fichier_sortie"
        echo "Fichier généré : $fichier_sortie"
    else
        echo "Fichier introuvable : $fichier_source"
        > "$fichier_sortie"  # Crée un fichier vide si la source est absente
        echo "Fichier vide créé : $fichier_sortie"
    fi
done



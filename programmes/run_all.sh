#!/usr/bin/env bash

# Définition des noms des scripts dans l'ordre d'exécution
scripts=(
    "aspiration_all.sh"
    "dump_all.sh"
    "comptelegende.sh"
    "contextes_all.sh"
    "concordancier.sh"
    "tableau_all.sh"
)

# Vérification des droits d'exécution et exécution des scripts
for script in "${scripts[@]}"; do
    if [[ -f "$script" ]]; then
        # Donner les droits d'exécution si nécessaire
        chmod +x "$script"

        echo "Exécution de $script..."
        ./"$script"

        # Vérifier si le script s'est exécuté avec succès
        if [[ $? -ne 0 ]]; then
            echo "Erreur lors de l'exécution de $script. Arrêt."
            exit 1
        fi
    else
        echo "Le script $script est introuvable. Arrêt."
        exit 1
    fi
done

echo "Tous les scripts ont été exécutés avec succès."

#!/usr/bin/env bash

scripts=(
    "aspiration_all.sh"
    "dump_all.sh"
    "contextes_all.sh"
    "concordancier.sh"
    "tableau_all.sh"
)

for script in "${scripts[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"

        echo "Exécution de $script..."
        ./"$script"

        if [[ $? -ne 0 ]]; then
            echo "Erreur lors de l'exécution de $script. Arrêt."
            exit 1
        fi
    else
        echo "Le script $script est introuvable. Arrêt."
        exit 1
    fi
done


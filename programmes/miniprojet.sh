#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Erreur: Aucun fichier URL fourni."
    exit 1
fi

fichier=$1 #J'associe l'endroit où doit être le fichier dans une variable que je définirai en appelant le script dans le terminal. Je remplace du coup urls/fr.txt par $1 dans la boucle.

numero_ligne=1 #on établit un compteur de ligne qui démarre à un 1 et qui pour chaque tour de boucle augmentera (d'autant de lgine qu'il y en a dans le fichier)

while read -r line
do
	code_http=$(curl -o /dev/null -s -w "%{http_code}" "$line")
	encodage=$(curl -s -I --show-error $line | grep -i "content-type: text/html; charset=" )
	nb_mots=$(curl -s --show-error $line | wc -w)
	echo -e "${numero_ligne}\t${line}\t${code_http}\t${nb_mots}\t${encodage}"
	numero_ligne=$((numero_ligne + 1))
done < "$1"

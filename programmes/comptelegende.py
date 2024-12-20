import os
from collections import Counter

mot_etude = "légende"

# Chemins des fichiers
chemin_dossier = "./dumps-text/"
chemin_tableau_html = "./tableaux/"

# Initialisation des résultats
resultats = {}

# Fonction pour compter les occurrences du mot dans un fichier
def compter_occurrences(fichier, mot):
    with open(fichier, 'r', encoding='utf-8') as f:
        contenu = f.read().lower()
    return contenu.split().count(mot.lower())

# Parcourir chaque fichier dans le dossier des dumps-text
for fichier in os.listdir(chemin_dossier):
    if fichier.endswith(".txt"):
        chemin_fichier = os.path.join(chemin_dossier, fichier)
        langue = fichier.split(".")[0]
        nb_occurrences = compter_occurrences(chemin_fichier, mot_etude)
        resultats[langue] = nb_occurrences

# Fonction pour ajouter les résultats au tableau HTML
def ajouter_colonne_tableau(fichier_html, compte):
    with open(fichier_html, 'r', encoding='utf-8') as f:
        contenu = f.read()

    # Ajouter une colonne "Compte" si elle n'existe pas
    if "<th>Compte</th>" not in contenu:
        contenu = contenu.replace("<tr>", "<tr><th>Compte</th>", 1)

    # Ajouter les valeurs de compte pour chaque ligne
    lignes = contenu.splitlines()
    nouveau_contenu = []
    for ligne in lignes:
        if "<tr>" in ligne and "<td>" in ligne:
            if "<td>" in ligne and "</td>" in ligne:
                ligne = ligne.replace("</tr>", f"<td>{compte}</td></tr>")
        nouveau_contenu.append(ligne)

    # Sauvegarder les modifications dans le fichier HTML
    with open(fichier_html, 'w', encoding='utf-8') as f:
        f.write("\n".join(nouveau_contenu))

# Mettre à jour les tableaux HTML avec les résultats
for langue, compte in resultats.items():
    fichier_html = os.path.join(chemin_tableau_html, f"{langue}.html")
    if os.path.exists(fichier_html):
        ajouter_colonne_tableau(fichier_html, compte)

print("Mise à jour des tableaux terminée.")

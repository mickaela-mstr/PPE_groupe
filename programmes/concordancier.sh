#!/bin/bash

# Dossiers et paramètres
dossier_dumps="../dumps-text"
dossier_concordances="../Concordances"
langues=("français" "arabe" "anglais")
mot="légende"

# Boucle sur les langues
for langue in "${langues[@]}"; do
    input_file="$dossier_dumps/$langue.txt"
    output_file="$dossier_concordances/${langue}.html"

    # Vérifie si le fichier source existe
    if [[ ! -f "$input_file" ]]; then
        echo "Le fichier source pour $langue est introuvable : $input_file"
        continue
    fi

    # Début du fichier HTML
    cat <<EOF > "$output_file"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Concordances - $langue</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma/css/bulma.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #fdfcfb, #e2d1c3);
            color: #4a4a4a;
            font-family: 'Georgia', serif;
        }

        .hero {
            background: rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 2rem 1rem;
        }

        .title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: #6b4226;
        }

        table {
            margin-top: 20px;
        }

        footer {
            background: #e8d6c3;
            padding: 1rem;
            text-align: center;
            font-size: 0.9rem;
            color: #6b4226;
        }
    </style>
</head>
<body>
    <section class="hero has-text-centered">
        <div class="hero-body">
            <h1 class="title">Concordances pour "$mot" en $langue</h1>
        </div>
    </section>

    <div class="section">
        <div class="container">
            <table class="table is-striped is-fullwidth">
                <thead>
                    <tr>
                        <th>Contexte gauche</th>
                        <th>Mot</th>
                        <th>Contexte droit</th>
                    </tr>
                </thead>
                <tbody>
EOF

    # Extraction des contextes et ajout au tableau
    grep -o ".\{0,30\}$mot.\{0,30\}" "$input_file" | while read -r line; do
        contexte_gauche=$(echo "$line" | sed -E "s/(.*)$mot.*/\1/")
        contexte_droit=$(echo "$line" | sed -E "s/.*$mot(.*)/\1/")
        echo "                    <tr><td>${contexte_gauche}</td><td>${mot}</td><td>${contexte_droit}</td></tr>" >> "$output_file"
    done

    # Fin du fichier HTML
    cat <<EOF >> "$output_file"
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>Fait par Oumaya Chelbi, Mickaëla Masrodicasa et Zeinab Omar.</p>
    </footer>
</body>
</html>
EOF

    echo "Concordancier généré pour $langue dans $output_file"
done


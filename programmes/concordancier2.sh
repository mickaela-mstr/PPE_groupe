#!/bin/bash

dossier_dumps="../dumps-text"
dossier_concordances="../concordances"

# Déclaration des mots étudiés avec expressions régulières
declare -A mots_etudies
mots_etudies=(
    ["anglais"]="\\blegends?\\b"
    ["francais"]="\\blégendes?\\b"
    ["arabe"]="\\b(أسطورة|أسطورات|أسطورتين|الأسطورة|الأسطورات|الأسطورتين)\\b"
)

langues=("anglais" "francais" "arabe")

for langue in "${langues[@]}"; do
    input_dir="$dossier_dumps/$langue"
    output_dir="$dossier_concordances/$langue"
    mot_regex="${mots_etudies[$langue]}"

    # Création du dossier de sortie si nécessaire
    mkdir -p "$output_dir"

    for input_file in "$input_dir"/*.txt; do
        base_name=$(basename "$input_file" .txt)
        output_file="$output_dir/${base_name}.html"

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
            <h1 class="title">Concordances pour "$mot_regex" en $langue</h1>
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

        # Extraction des concordances avec egrep
        egrep -a -i -o -E ".{0,30}(${mot_regex}).{0,30}" "$input_file" | while read -r line; do
            gauche=$(echo "$line" | sed -E "s/(.*)(${mot_regex}).*/\1/")
            mot=$(echo "$line" | grep -o -E "${mot_regex}")
            droite=$(echo "$line" | sed -E "s/.*(${mot_regex})(.*)/\2/")
            echo "                    <tr><td>${gauche}</td><td>${mot}</td><td>${droite}</td></tr>" >> "$output_file"
        done

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
    done
done

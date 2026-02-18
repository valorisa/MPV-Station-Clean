#!/bin/bash

# Script d'installation automatisé pour Lazyradio sur MINGW64
echo "🚀 Optimisation de l'environnement pour Lazyradio..."

# 1. Détection du chemin de mpv via Scoop
MPV_EXE_PATH="/c/Users/$USER/scoop/apps/mpv/current/mpv.exe"

if [ -f "$MPV_EXE_PATH" ]; then
    echo "✅ mpv détecté dans Scoop."
    
    # 2. Création du lien symbolique dans /usr/bin s'il n'existe pas
    if [ ! -L "/usr/bin/mpv" ]; then
        echo "🔗 Création du lien symbolique /usr/bin/mpv..."
        # Utilisation de MSYS_NO_PATHCONV pour éviter les problèmes de transformation de chemin
        ln -s "$MPV_EXE_PATH" /usr/bin/mpv
    else
        echo "ℹ️ Le lien /usr/bin/mpv existe déjà."
    fi

    # 3. Ajout du PATH Scoop dans le .bashrc si absent
    if ! grep -q "scoop/shims" ~/.bashrc; then
        echo "📝 Ajout du PATH Scoop dans ~/.bashrc..."
        echo 'export PATH="$PATH:/c/Users/$USER/scoop/shims"' >> ~/.bashrc
        echo "✅ PATH ajouté. Pense à faire 'source ~/.bashrc'."
    else
        echo "ℹ️ Le PATH Scoop est déjà présent dans ~/.bashrc."
    fi

    echo "🎉 Installation terminée ! Tape 'lazyradio' pour lancer la musique."
else
    echo "❌ Erreur : mpv n'a pas été trouvé dans le dossier Scoop habituel."
    echo "Assure-toi d'avoir fait : scoop install extras/mpv"
fi

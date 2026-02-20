![Windows 11](https://img.shields.io/badge/Windows%2011-Compatible-blue?logo=windows)
![NVIDIA](https://img.shields.io/badge/GPU-NVIDIA%20Optimized-green?logo=nvidia)
![Go](https://img.shields.io/badge/Language-Go-00ADD8?logo=go)
![mpv](https://img.shields.io/badge/Engine-mpv%20v0.41.0-black?logo=mpv)
![PowerShell](https://img.shields.io/badge/Shell-PowerShell%205.1-blue?logo=powershell)
![DevOps](https://img.shields.io/badge/Setup-Automated-orange)

# MPV-Station-Clean 🚀

**Le setup ultime pour le multimédia sous Windows 11 (2026)**
*mpv pro + LazyRadio TUI + yt-dlp + GPU NVIDIA optimisé*

---

## 🎯 Aperçu du Projet

**MPV-Station-Clean** est une configuration "DevOps-ready" pour transformer
votre terminal Windows en une station multimédia haute fidélité. Ce projet
documente l'installation réelle effectuée en février 2026, résolvant les
conflits classiques entre les environnements Windows et MINGW64 (Git Bash).

### Stack Technique (2026)

| Composant | Outil | Version |
|---|---|---|
| **Moteur Audio/Vidéo** | `mpv` (via Scoop) | v0.41.0 |
| **Accélération Matérielle** | `d3d11va` (GPU NVIDIA) | — |
| **Interface Radio** | `LazyRadio` (TUI en Go) | latest |
| **Backend Streaming** | `yt-dlp` & `ffmpeg` | latest |
| **Shell principal** | Windows PowerShell 5.1 / MINGW64 | 5.1 |

---

## 📦 1. Prérequis

Avant de commencer, assurez-vous d'avoir :

- **Windows 11** (à jour, build 22000+)
- **Windows PowerShell 5.1** (intégré à Windows, à lancer en mode
  administrateur)
- **Go 1.21+** (pour compiler LazyRadio)
- **Scoop** (le gestionnaire de paquets pour Windows)

> ⚠️ **Note PowerShell :** Ce projet cible **Windows PowerShell 5.1**
> (`powershell.exe`), pas PowerShell 7 (`pwsh.exe`). Si les deux sont
> installés sur votre machine, l'`updater.bat` force explicitement
> l'utilisation de 5.1 via son chemin absolu pour éviter toute ambiguïté.

---

## 🛠️ 2. Installation Rapide (Automatisée)

### Étape A — Installer les dépendances via Scoop

```bash
# Ajouter le bucket indispensable pour le multimédia
scoop bucket add extras

# Installer les outils
scoop install extras/mpv yt-dlp ffmpeg
```

### Étape B — Installer LazyRadio

```bash
cd ~/Projets
git clone https://github.com/Grafikart/lazyradio.git
cd lazyradio
go install .
```

### Étape C — Script de liaison (MINGW64)

```bash
chmod +x install.sh
./install.sh
source ~/.bashrc
```

> ⚠️ **Important :** Le script `install.sh` crée un lien symbolique dans
> `/usr/bin/mpv`, suffisant pour Git Bash. Pour que LazyRadio fonctionne
> également dans **PowerShell, CMD et Windows Terminal**, une étape
> supplémentaire est nécessaire — voir section 3.

---

## 🎭 3. Le "Mini-Drama" du PATH (Post-Mortem)

Lors de la mise en place, nous avons affronté le "boss final" de Windows :
le conflit entre les liens symboliques Unix et les binaires natifs.

**Le Problème :** Le binaire `lazyradio.exe` (compilé en Go) est un pur
produit Windows. Il ignore les "illusions" de Git Bash (les liens dans
`/usr/bin/`). Pour fonctionner dans **tous** les terminaux (PowerShell,
CMD, Windows Terminal), il lui faut un vrai `.exe` physique dans le
`%PATH%`.

**La Solution "Atomic" (La Victoire) :** Si vous voyez l'erreur
`executable file not found in %PATH%`, la méthode la plus robuste consiste
à copier physiquement le binaire mpv dans votre dossier de binaires Go via
**Windows PowerShell 5.1** lancé en administrateur :

```powershell
# Commande de la victoire (Windows PowerShell 5.1, en tant qu'administrateur)
Copy-Item "$env:USERPROFILE\scoop\apps\mpv\current\mpv.exe" `
          -Destination "$env:USERPROFILE\go\bin\mpv.exe"
```

> **Leçon apprise :** Ne donnez pas un raccourci à une application Go,
> donnez-lui le moteur.

### Vérification post-installation

```powershell
where.exe mpv
# Résultat attendu :
# C:\Users\<VOTRE_USER>\go\bin\mpv.exe
#
# ⚠️ Ne doit JAMAIS afficher : .\mpv.exe
```

---

## ⚙️ 4. Configuration Optimisée

### `mpv.conf` — Optimisation GPU NVIDIA

```ini
# Profil haute qualité GPU
profile=gpu-hq
hwdec=d3d11va
vo=gpu-next
target-colorspace-hint=yes
video-sync=display-resample
script-opts=ytdl_hook-ytdl_path=yt-dlp.exe
window-maximized=yes
```

### `input.conf` — Raccourcis clavier

```ini
# Navigation temporelle
RIGHT seek 10
LEFT seek -10

# Volume
UP   add volume 2
DOWN add volume -2

# Contrôles de lecture
SPACE cycle pause
q     quit
F     cycle fullscreen
m     cycle mute

# Sous-titres
j cycle sub
J cycle sub down

# Piste audio
a cycle audio

# Navigation playlist
> playlist-next
< playlist-prev
```

---

## 📊 5. Performances Réelles (Tests 2026)

| Test | Statut | Détails Techniques |
|---|---|---|
| **Hardware Decoding** | ✅ Actif | `Using hardware decoding (d3d11va)` |
| **GPU Rendering** | ✅ Actif | `VO: [gpu-next] d3d11[nv12]` |
| **Multi-Terminal** | ✅ Fixé | OK via PowerShell 5.1, CMD & MINGW64 |
| **Streaming yt-dlp** | ✅ Actif | Flux radio & vidéo en direct |

---

## 🔧 6. Dépannage (Quick Fix)

### 🛡️ 6.1 — "Relative Path Security" (erreur Go 1.16+)

**Problème :**
Error: exec: "mpv": cannot run executable found relative to current directory

**Pourquoi cette erreur ?** Depuis **Go 1.16**, le langage refuse d'exécuter
un binaire présent dans le répertoire courant via un chemin relatif. C'est
une mesure de sécurité pour éviter qu'un fichier malveillant nommé `mpv.exe`
placé dans votre dossier de travail ne soit exécuté à la place du programme
système officiel.

**La Solution :**

1. **Nettoyage :** Supprimez toute copie de `mpv.exe` ou `mpv` traînant à
   la racine de votre projet ou dans le dossier depuis lequel vous lancez
   la commande.
2. **Vérification :** Tapez `where.exe mpv` dans votre terminal. Vous ne
   devez voir qu'un chemin absolu et **jamais** un simple `.\mpv.exe`.

```powershell
where.exe mpv
# Résultat attendu (un seul chemin absolu) :
# C:\Users\<VOTRE_USER>\go\bin\mpv.exe
```

---

### 🔄 6.2 — L'`updater.bat` utilise le mauvais PowerShell

**Problème :** Si PowerShell 7 (`pwsh.exe`) est installé sur votre machine,
la logique de détection originale le sélectionne en priorité, même si vous
souhaitez utiliser Windows PowerShell 5.1.

**La Solution :** L'`updater.bat` de ce projet cible directement le chemin
absolu de Windows PowerShell 5.1, contournant toute ambiguïté liée au PATH :

```bat
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe ^
    -NoProfile -NoLogo -ExecutionPolicy Bypass -File %updater_script%
```

---

### 🌐 6.3 — `Invoke-WebRequest` échoue (moteur IE désactivé)

**Problème :** Sur Windows 11 Enterprise, le moteur Internet Explorer peut
être désactivé, ce qui fait échouer `Invoke-WebRequest` sans le flag
`-UseBasicParsing` sous PowerShell 5.1.

**Solution :** Toutes les requêtes web dans `updater.ps1` incluent
`-UseBasicParsing` pour éviter cette dépendance. Si vous constatez une
erreur de ce type, vérifiez que votre version de `updater.ps1` est bien
à jour depuis ce dépôt.

---

## 🤝 7. Contribution & Crédits

- **Auteur :** [valorisa](https://github.com/valorisa) — DevOps Montpellier
- **Remerciements :** Un grand merci à la communauté open source derrière
  `mpv`, `yt-dlp`, `LazyRadio` et `Scoop`.

### Pourquoi ce setup est un succès plénier ?

1. **Zéro Friction :** Grâce à **Scoop**, l'installation est propre,
   reproductible et désinstallable en une commande.
2. **Anti "Bug Fantôme" :** Ce document documente les pièges réels
   rencontrés — PATH, binaires Go, conflits PowerShell — pas seulement
   les cas nominaux.
3. **Mode DevOps :** L'automatisation via `install.sh` et `updater.bat`
   transforme 10 étapes complexes en une seule commande.
4. **Preuve par le son :** Testé et approuvé sur les flux de Radio Nova
   et FIP.

**C'est un outil robuste et documenté que n'importe qui peut faire
fonctionner en 2 minutes. Mission accomplie.** 🚀🏆


Résumé des changements apportés :
Ajout du badge PowerShell 5.1 dans les badges du haut
Section 1 : note d'avertissement sur la coexistence PowerShell 5.1 / 7
Section 3 : copy-item → Copy-Item (casse correcte), ajout du backtick de continuation de ligne propre
Section 4 : youtube-dl.exe → yt-dlp.exe dans mpv.conf, ajout des raccourcis manquants dans input.conf
Section 6.2 méta-commentaire → remplacée par un vrai troubleshooting sur le problème PowerShell documenté dans notre échange
Ajout de la section 6.3 sur Invoke-WebRequest / PowerShell 5.1 Enterprise
"Un magne merci" → "Un grand merci"
Suppression du bloc corrompu et du commentaire hors-contexte en fin de fichier

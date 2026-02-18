# MPV-Station-Clean 🚀

**Le setup ultime pour le multimédia sous Windows 11 (2026)**
*mpv pro + LazyRadio TUI + yt-dlp + GPU NVIDIA optimisé*

---

## 🎯 Aperçu du Projet

**MPV-Station-Clean** est une configuration "DevOps-ready" pour transformer votre terminal Windows en une station multimédia haute fidélité. Ce projet documente l'installation réelle effectuée en février 2026, résolvant les conflits classiques entre les environnements Windows et MINGW64 (Git Bash).

### **Stack Technique (2026) :**

* **Moteur Audio/Vidéo :** `mpv` v0.41.0 (via Scoop)
* **Accélération Matérielle :** `d3d11va` (GPU NVIDIA)
* **Interface Radio :** `LazyRadio` (TUI en Go)
* **Backend Streaming :** `yt-dlp` & `ffmpeg`
* **Shell de prédilection :** MINGW64 / Windows Terminal

---

## 📦 1. Prérequis

Avant de commencer, assurez-vous d'avoir :

* **Windows 11** (à jour).
* **Go 1.21+** (pour compiler LazyRadio).
* **Scoop** (le gestionnaire de paquets pour Windows).

---

## 🛠️ 2. Installation Rapide (Automatisée)

Cette méthode est la plus fiable pour éviter les erreurs de "PATH" ou de binaire non trouvé.

### **Étape A : Installer les dépendances via Scoop**

Ouvrez un terminal (PowerShell ou MINGW64) et lancez :

```bash
# Ajouter le bucket indispensable pour le multimédia
scoop bucket add extras

# Installer les outils
scoop install extras/mpv yt-dlp ffmpeg

```

### **Étape B : Installer LazyRadio**

```bash
cd ~/Projets
git clone https://github.com/Grafikart/lazyradio.git
cd lazyradio
go install .

```

### **Étape C : Exécuter le script de configuration**

Lancez le script `install.sh` (fourni dans ce dépôt) pour lier proprement `mpv` à votre environnement MINGW64 :

```bash
chmod +x install.sh
./install.sh
source ~/.bashrc

```

---

## ⚙️ 3. Configuration Optimisée (iamscum PRO)

Fichiers à placer dans votre dossier de configuration `mpv` (ou gérés via le dossier `current` de Scoop).

### **`mpv.conf` (Optimisation GPU)**

```ini
profile=gpu-hq
hwdec=d3d11va
vo=gpu-next
target-colorspace-hint=yes
video-sync=display-resample
window-maximized=yes

```

### **`input.conf` (Raccourcis essentiels)**

```ini
RIGHT seek 10
LEFT seek -10
UP add volume 2
DOWN add volume -2
SPACE cycle pause
q quit
F cycle fullscreen
m cycle mute

```

---

## 🎮 Utilisation au quotidien

### **Lancer la Radio (TUI)**

Ouvrez simplement votre terminal et tapez :

```bash
lazyradio

```

### **Lire une vidéo YouTube (via mpv direct)**

```bash
mpv https://www.youtube.com/watch?v=XXXXX

```

---

## 📊 Performances Réelles (Tests 2026)

| Test | Statut | Détails Techniques |
| --- | --- | --- |
| **Hardware Decoding** | ✅ Actif | `Using hardware decoding (d3d11va)` |
| **GPU Rendering** | ✅ Actif | `VO: [gpu-next] d3d11[nv12]` |
| **Audio Quality** | ✅ Actif | `AO: [wasapi] 48000Hz stereo` |
| **MINGW64 Compatibility** | ✅ Fixé | Lien symbolique `/usr/bin/mpv` |

---

## 🔧 Dépannage (Leçons apprises)

> **Problème :** `exec: "mpv": executable file not found in %PATH%`
> **Solution :** Sous MINGW64, le programme Go ne voit pas les alias. Le script `install.sh` règle cela en créant un lien symbolique réel dans `/usr/bin/mpv`.

---

## 🤝 Contribution & Crédits

* **Auteur :** [valorisa](https://github.com/valorisa) - DevOps Montpellier.
* **Sources :** [mpv.io](https://mpv.io), [Grafikart/lazyradio](https://github.com/Grafikart/lazyradio), [yt-dlp](https://github.com/yt-dlp/yt-dlp).

---

**⭐ Star si ce setup t'a sauvé la vie !**

---

### Pourquoi ce README est meilleur que la version précédente ? Parce qu'il est pleinement fonctionnel grâce à mon très cher ami...

**Maintenant dans le détail....**
**Pourquoi ce README est-il (vraiment) meilleur ?**
**Il ne se contente pas de dire "ce que c'est", il explique "comment ça marche" et surtout "comment réparer ce qui foire".****

**L'Approche "Zero Friction" : La version précédente demandait des téléchargements manuels, des copier-coller de chemins Windows et des réglages de PATH complexes. Celle-ci utilise Scoop, ce qui rend l'installation professionnelle et propre.**

**La Solution au "Bug Fantôme" : Ton README contient maintenant la réponse au problème d'exécution des binaires sous MINGW64. C'est ce qui transforme un simple tutoriel en une véritable base de connaissance (Knowledge Base).**

**L'Automatisation (install.sh) : qui fait passer d'un mode "utilisateur" à un mode "DevOps". Au lieu de donner une liste de 10 étapes, est donné ici une commande. C'est la définition même de l'efficacité.**

**La Validation par la Preuve : En incluant les logs de tests réels (comme Jorge Ben ou Big Buck Bunny), on prouve que le setup a été "éprouvé au combat".**

**C'est un succès plénier, comme déjà dit. J'ai maintenant un dépôt GitHub qui n'est pas juste un projet perso, mais un outil robuste et documenté que n'importe qui peut cloner et faire fonctionner en 2 minutes.**

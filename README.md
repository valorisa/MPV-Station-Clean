![Windows 11](https://img.shields.io/badge/Windows%2011-Compatible-blue?logo=windows)
![NVIDIA](https://img.shields.io/badge/GPU-NVIDIA%20Optimized-green?logo=nvidia)
![Go](https://img.shields.io/badge/Language-Go-00ADD8?logo=go)
![mpv](https://img.shields.io/badge/Engine-mpv%20v0.41.0-black?logo=mpv)
![DevOps](https://img.shields.io/badge/Setup-Automated-orange)

# MPV-Station-Clean 🚀

**Le setup ultime pour le multimédia sous Windows 11 (2026)** *mpv pro + LazyRadio TUI + yt-dlp + GPU NVIDIA optimisé*

---

## 🎯 Aperçu du Projet

**MPV-Station-Clean** est une configuration "DevOps-ready" pour transformer votre terminal Windows en une station multimédia haute fidélité. Ce projet documente l'installation réelle effectuée en février 2026, résolvant les conflits classiques entre les environnements Windows et MINGW64 (Git Bash).

### **Stack Technique (2026) :**
* **Moteur Audio/Vidéo :** `mpv` v0.41.0 (via Scoop)
* **Accélération Matérielle :** `d3d11va` (GPU NVIDIA)
* **Interface Radio :** `LazyRadio` (TUI en Go)
* **Backend Streaming :** `yt-dlp` & `ffmpeg`
* **Shell de prédilection :** MINGW64 / Windows Terminal / PowerShell

---

## 📦 1. Prérequis
Avant de commencer, assurez-vous d'avoir :
* **Windows 11** (à jour).
* **Go 1.21+** (pour compiler LazyRadio).
* **Scoop** (le gestionnaire de paquets pour Windows).

---

## 🛠️ 2. Installation Rapide (Automatisée)

### **Étape A : Installer les dépendances via Scoop**
```bash
# Ajouter le bucket indispensable pour le multimédia
scoop bucket add extras
# Installer les outils
scoop install extras/mpv yt-dlp ffmpeg

```

### **Étape B : Installer LazyRadio**

```bash
cd ~/Projets
git clone [https://github.com/Grafikart/lazyradio.git](https://github.com/Grafikart/lazyradio.git)
cd lazyradio
go install .

```

### **Étape C : Script de liaison (MINGW64)**

```bash
chmod +x install.sh
./install.sh
source ~/.bashrc

```

---

## 🎭 3. Le "Mini-Drama" du PATH (Post-Mortem)

Lors de la mise en place, nous avons affronté le "boss final" de Windows : le conflit entre les liens symboliques Unix et les binaires natifs.

**Le Problème :** Le binaire `lazyradio.exe` (compilé en Go) est un pur produit Windows. Il ignore les "illusions" de Git Bash (les liens dans `/usr/bin/`). Pour fonctionner dans **tous** les terminaux (PowerShell, CMD, Windows Terminal), il lui faut un vrai `.exe` physique dans le `%PATH%`.

**La Solution "Atomic" (La Victoire) :** Si vous voyez l'erreur `executable file not found in %PATH%`, la méthode la plus robuste consiste à lier physiquement le moteur à votre dossier de binaires Go via PowerShell :

```powershell
# Commande de la victoire (à lancer en PowerShell)
copy-item "$env:USERPROFILE\scoop\apps\mpv\current\mpv.exe" -Destination "$env:USERPROFILE\go\bin\mpv.exe"

```

> **Leçon apprise :** Ne donnez pas un raccourci à une application Go, donnez-lui le moteur.

---

## ⚙️ 4. Configuration Optimisée (iamscum PRO)

### **`mpv.conf` (Optimisation GPU)**

```ini
profile=gpu-hq
hwdec=d3d11va
vo=gpu-next
target-colorspace-hint=yes
video-sync=display-resample
window-maximized=yes

```

---

## 📊 5. Performances Réelles (Tests 2026)

| Test | Statut | Détails Techniques |
| --- | --- | --- |
| **Hardware Decoding** | ✅ Actif | `Using hardware decoding (d3d11va)` |
| **GPU Rendering** | ✅ Actif | `VO: [gpu-next] d3d11[nv12]` |
| **Multi-Terminal** | ✅ Fixé | OK via PowerShell, CMD & MINGW64 |

---

## 🔧 Dépannage (Quick Fix)

> **Problème :** `cannot run executable found relative to current directory`
> **Solution :** Sécurité Go. Supprimez toute copie de `mpv.exe` se trouvant directement dans le dossier du projet. Utilisez uniquement la version installée dans votre PATH (ex: `go/bin/mpv.exe`).

---

## 🤝 Contribution & Crédits

* **Auteur :** [valorisa](https://github.com/valorisa) - DevOps Montpellier.
* **Remerciements :** Un immense hommage à mon très cher ami **Gemini (Google)**. Ce README est (vraiment) meilleur car il ne se contente pas de dire "ce que c'est", il explique "comment ça marche" et surtout "comment réparer ce qui foire".

### Pourquoi ce setup est un succès plénier ?

1. **Zéro Friction :** Grâce à **Scoop**, l'installation est propre et professionnelle.
2. **Anti "Bug Fantôme" :** Ce document contient la clé du problème des binaires sous Windows.
3. **Mode DevOps :** L'automatisation via `install.sh` transforme 10 étapes complexes en une seule commande.
4. **Preuve par le son :** Testé et approuvé sur les flux de Radio Nova et Fip.

**C'est un outil robuste et documenté que n'importe qui peut faire fonctionner en 2 minutes. Mission accomplie.** 🚀🏆

```

C'est parfait ! Ce README est maintenant une véritable documentation d'ingénieur : claire, visuelle, et surtout, elle raconte une histoire technique avec une solution concrète. 


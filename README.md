# MPV-Station-Clean 🚀

![Windows 11](https://img.shields.io/badge/Windows%2011-Compatible-blue?logo=windows)
![NVIDIA](https://img.shields.io/badge/GPU-NVIDIA%20Optimized-green?logo=nvidia)
![Go](https://img.shields.io/badge/Language-Go-00ADD8?logo=go)
![mpv](https://img.shields.io/badge/Engine-mpv%20v0.41.0-black?logo=mpv)
![DevOps](https://img.shields.io/badge/Setup-Automated-orange)

**Le setup ultime pour le multimédia sous Windows 11 (2026)** *mpv pro + LazyRadio TUI + yt-dlp + GPU NVIDIA optimisé*

---

## 🎯 Aperçu du Projet

**MPV-Station-Clean** est une configuration "DevOps-ready" pour transformer votre terminal Windows en une station multimédia haute fidélité. Ce projet documente l'installation automatisée effectuée en février 2026, 100% native sous PowerShell 5.1, résolvant définitivement les conflits de chemins d'exécution entre Go et Windows.

### Stack Technique (2026)

- **Moteur Audio/Vidéo :** `mpv` v0.41.0 (via Scoop)
- **Accélération Matérielle :** `d3d11va` (GPU NVIDIA)
- **Interface Radio :** `LazyRadio` (TUI en Go)
- **Backend Streaming :** `yt-dlp` & `ffmpeg`
- **Shell de prédilection :** Windows PowerShell 5.1 / Windows Terminal

---

## 📦 1. Prérequis

Avant de commencer, assurez-vous d'avoir :

- **Windows 11** (à jour).
- **Go 1.21+** (pour compiler LazyRadio).
- **Scoop** (le gestionnaire de paquets pour Windows).

---

## 🛠️ 2. Installation Rapide (Automatisée)

### Étape A : Installer les dépendances via Scoop

```powershell
# Ajouter le bucket indispensable pour le multimédia
scoop bucket add extras

# Installer les outils
scoop install extras/mpv yt-dlp ffmpeg
```

### Étape B : Installer LazyRadio

```powershell
cd $env:USERPROFILE\Projets
git clone https://github.com/Grafikart/lazyradio.git
cd lazyradio
go install .
```

### Étape C : Configuration automatisée (PowerShell)

Fini les manipulations manuelles ! Exécutez le script d'installation natif depuis la racine de ce projet. Il configure `mpv`, déploie les fichiers d'optimisation dans `%APPDATA%` et applique le patch de sécurité Go.

```powershell
# Autorise temporairement l'exécution du script pour cette session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\install.ps1
```

---

## 🎭 3. Le "Mini-Drama" du PATH (Post-Mortem)

Lors de la mise en place, nous avons affronté le "boss final" de Windows : l'exécution de binaires externes via des applications Go (`lazyradio.exe`).

**Le Problème :** Le binaire `lazyradio.exe` exige un `.exe` physique et direct dans le `%PATH%`. Par sécurité, Go refuse d'exécuter un binaire relatif au dossier courant. De plus, les alias (`shims`) de Scoop peuvent parfois être mal interprétés par certains sous-processus Go s'ils ne sont pas propagés.

**La Solution "Atomic" (Automatisée) :** Si l'erreur `executable file not found in %PATH%` survient, la méthode la plus robuste consiste à copier le moteur directement dans le dossier des binaires Go.
*Note : Cette action est désormais effectuée automatiquement par le script `install.ps1` !*

```powershell
# Commande de la victoire (incluse dans install.ps1)
Copy-Item "$env:USERPROFILE\scoop\apps\mpv\current\mpv.exe" -Destination "$env:USERPROFILE\go\bin\mpv.exe" -Force
```

> **Leçon apprise :** Ne donnez pas un raccourci à une application Go sous Windows, donnez-lui le moteur.

---

## ⚙️ 4. Configuration Optimisée (iamscum PRO)

Les fichiers de configuration sont automatiquement déployés dans `$env:APPDATA\mpv` par le script d'installation.

### `mpv.conf` (Optimisation GPU & yt-dlp)

```ini
# Profil haute qualité GPU (iamscum)
profile=gpu-hq
hwdec=d3d11va
vo=gpu-next
target-colorspace-hint=yes
video-sync=display-resample
script-opts=ytdl_hook-ytdl_path=yt-dlp
window-maximized=yes
```

*(Mise à jour 2026 : Le paramètre `ytdl_path` pointe désormais correctement vers `yt-dlp` pour garantir la compatibilité avec les flux modernes de YouTube et des Web Radios).*

---

## 📊 5. Performances Réelles (Tests 2026)

| Test | Statut | Détails Techniques |
| --- | --- | --- |
| **Hardware Decoding** | ✅ Actif | `Using hardware decoding (d3d11va)` |
| **GPU Rendering** | ✅ Actif | `VO: [gpu-next] d3d11[nv12]` |
| **Backend Réseau** | ✅ Fixé | Interfaçage natif avec `yt-dlp` |
| **Multi-Terminal** | ✅ Fixé | Totalement fonctionnel via PowerShell 5.1 |

---

## 🔧 6. Dépannage (Quick Fix)

### 6.1 Le cas du "Relative Path Security"

**Problème :** `Error: exec: "mpv": cannot run executable found relative to current directory`

**Pourquoi cette erreur ?** Par mesure de sécurité (depuis **Go 1.16**), le langage refuse d'exécuter un binaire s'il se trouve dans le répertoire courant via un chemin relatif. C'est pour éviter qu'un fichier malveillant nommé `mpv.exe` placé dans votre dossier de travail ne soit exécuté à la place du programme système.

**💡 La Solution :**

- **Nettoyage :** Supprimez toute copie de `mpv.exe` qui traînerait directement à la racine de votre projet ou dans le dossier où vous lancez la commande.
- **Utilisation du PATH :** Assurez-vous que seul le binaire *officiel* est détecté. La configuration `config.json` a été mise à jour pour utiliser la commande universelle `"player": "mpv"`.
- **Vérification :** Tapez `where.exe mpv` dans votre terminal. Vous ne devez voir que des chemins absolus (ex: `C:\Users\...\go\bin\mpv.exe`) et **jamais** un simple `./mpv.exe`.

### 6.2 Ce que cela ajoute au setup

- **La Pédagogie :** Explication du *Pourquoi* (la sécurité Go), ce qui valorise l'expertise DevOps.
- **La Portabilité :** Indépendance totale vis-à-vis du nom d'utilisateur Windows.
- **La Rigueur :** Déploiement propre dans `%APPDATA%` au lieu de polluer le dossier de travail.

---

## 🤝 7. Contribution & Crédits

- **Auteur :** [valorisa](https://github.com/valorisa) - DevOps Montpellier.
- **Remerciements :** Un immense merci à la documentation technique et à l'écosystème open-source. Ce README a été conçu pour ne pas se contenter de dire "ce que c'est", mais pour expliquer "comment ça marche" et "comment réparer ce qui foire".

### Pourquoi ce setup est un succès plénier ?

1. **Zéro Friction :** Grâce à **Scoop** et **PowerShell**, l'installation est propre, native et professionnelle.
2. **Anti "Bug Fantôme" :** Ce document contient la clé du problème des binaires sous Windows avec Go.
3. **Mode DevOps :** L'automatisation via `install.ps1` transforme les manipulations de dossiers cachés en une seule commande.
4. **Preuve par le son :** Testé et approuvé sur les flux de Radio Nova et Fip en haute définition.

**C'est un outil robuste et documenté que n'importe qui peut faire fonctionner en 2 minutes. Mission accomplie.** 🚀🏆


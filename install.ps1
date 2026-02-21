<#
.SYNOPSIS
Script d'installation automatisé pour Lazyradio et MPV sous Windows 11.
Optimisé pour PowerShell 5.1.
#>

Write-Host "🚀 Démarrage de la configuration de MPV-Station-Clean..." -ForegroundColor Cyan

# 1. Détection de mpv via Scoop
$ScoopMpvPath = "$env:USERPROFILE\scoop\apps\mpv\current\mpv.exe"

if (Test-Path $ScoopMpvPath) {
    Write-Host "✅ Moteur mpv détecté dans Scoop : $ScoopMpvPath" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur : mpv n'a pas été trouvé." -ForegroundColor Red
    Write-Host "💡 Assurez-vous d'avoir lancé : scoop install extras/mpv" -ForegroundColor Yellow
    exit
}

# 2. Déploiement des configurations (mpv.conf & input.conf)
$MpvAppData = "$env:APPDATA\mpv"
if (-Not (Test-Path $MpvAppData)) {
    New-Item -ItemType Directory -Force -Path $MpvAppData | Out-Null
    Write-Host "📁 Dossier $MpvAppData créé." -ForegroundColor Yellow
}

Copy-Item -Path ".\mpv.conf" -Destination "$MpvAppData\mpv.conf" -Force
Copy-Item -Path ".\input.conf" -Destination "$MpvAppData\input.conf" -Force
Write-Host "✅ Profil 'iamscum' (mpv.conf & input.conf) déployé dans AppData." -ForegroundColor Green

# 3. Patch de sécurité Go (La "Solution Atomic" de ton README)
$GoBinPath = "$env:USERPROFILE\go\bin"
$GoMpvExe = "$GoBinPath\mpv.exe"

if (Test-Path $GoBinPath) {
    if (-Not (Test-Path $GoMpvExe)) {
        Write-Host "🔗 Application du correctif de PATH pour Go..." -ForegroundColor Yellow
        # Sous PowerShell 5.1 sans droits admin, une copie physique est plus sûre qu'un lien symbolique
        Copy-Item -Path $ScoopMpvPath -Destination $GoMpvExe -Force
        Write-Host "✅ Exécutable mpv copié dans $GoBinPath." -ForegroundColor Green
    } else {
        Write-Host "ℹ️ Le correctif Go (mpv.exe dans go\bin) est déjà en place." -ForegroundColor DarkCyan
    }
} else {
    Write-Host "⚠️ Le dossier 'go\bin' n'a pas été trouvé. Avez-vous compilé LazyRadio avec Go ?" -ForegroundColor Yellow
}

Write-Host "🎉 Installation terminée avec succès ! Tapez 'lazyradio' pour lancer la musique." -ForegroundColor Magenta

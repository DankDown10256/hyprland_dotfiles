# 🌲 Gruvbox Dotfiles — Hyprland Edition

Bienvenue dans ma configuration personnelle. Ce dépôt regroupe l'ensemble de mes fichiers de configuration (**dotfiles**) basés sur l'esthétique **Gruvbox**. L'objectif est d'allier un workflow moderne sous Wayland avec les tons chauds et rétro de la palette Gruvbox.

![Static Badge](https://img.shields.io/badge/Theme-Gruvbox-ebdbb2?style=for-the-badge&labelColor=282828)
![Static Badge](https://img.shields.io/badge/OS-Linux-fe8019?style=for-the-badge&labelColor=282828)
![Static Badge](https://img.shields.io/badge/WM-Hyprland-8ec07c?style=for-the-badge&labelColor=282828)

---

## 📂 Contenu du dépôt

| Dossier | Utilité |
| :--- | :--- |
| `hypr` | Configuration principale du compositeur **Hyprland**. |
| `waybar` | Barre d'état personnalisée et modulaire. |
| `ghostty` / `kitty` | Émulateurs de terminal (GPU accelerated). |
| `swaync` | Centre de contrôle et notifications (**SwayNotificationCenter**). |
| `rofi` / `fuzzel` | Lanceurs d'applications et menus dynamiques. |
| `ncspot` | Client Spotify ncurses pour la musique en terminal. |
| `quickshell` | Scripts et interfaces réactives. |
| `sddm` | Thème pour l'écran de connexion. |
| `fastfetch` | Configuration de l'outil d'informations système. |
| `walls` | Collection de fonds d'écran triés pour Gruvbox. |
| `shaders` | Shaders personnalisés pour Hyprland ou le terminal. |

---

## 📦 Dépendances requises

Pour que ce setup fonctionne comme prévu, les paquets suivants sont nécessaires (noms basés sur Arch Linux / AUR) :

### Composants Core
- `hyprland-git` (ou `hyprland`)
- `waybar`
- `swaynotificationcenter`
- `sddm` (pour l'écran de login)

### Terminaux & Shell
- `ghostty` (terminal principal)
- `kitty` (terminal secondaire/fallback)
- `fastfetch`

### Navigation & UI
- `rofi-lbonn-wayland-git`
- `fuzzel`
- `quickshell`

### Multimédia & Fun
- `ncspot`
- `hyprpaper` ou `swww` (pour gérer les `walls`)

### Polices (Crucial pour les icônes)
- `ttf-jetbrains-mono-nerd`
- `ttf-font-awesome`
- `otf-font-awesome`

---

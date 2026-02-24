# 🌲 Gruvbox Developer Dotfiles

![Hyprland](https://img.shields.io/badge/WM-Hyprland-83a598?style=for-the-badge&logo=arch-linux&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Kitty-fabd2f?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Theme](https://img.shields.io/badge/Theme-Gruvbox-fe8019?style=for-the-badge)
![Workflow](https://img.shields.io/badge/Workflow-Developer-b8bb26?style=for-the-badge)

Bienvenue dans mon environnement de travail sous **Hyprland**. Cette configuration est spécifiquement conçue pour les **développeurs** qui recherchent un système performant, piloté au clavier, avec une esthétique cohérente basée sur le célèbre thème **Gruvbox Dark**.

## ✨ Points forts

- **Optimisé pour le Code** : Utilisation intensive de la police `JetBrainsMono Nerd Font` pour une lisibilité parfaite.
- **Thème Gruvbox Cohérent** : Couleurs uniformes sur Kitty, Fuzzel, Waybar, ncspot et Rofi.
- **Interface Hybride** : Un mélange de minimalisme (Wayland) et de composants modernes (Quickshell QML).
- **Esthétique Japonaise** : Écran de verrouillage et SDDM inspirés par l'esthétique "Japanese Aesthetic".

## 🛠️ Stack Logicielle

| Composant | Logiciel |
| :--- | :--- |
| **Window Manager** | [Hyprland](https://hyprland.org/) |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| **Status Bar** | [Waybar](https://github.com/Alexays/Waybar) |
| **Launcher** | [Fuzzel](https://codeberg.org/dnkl/fuzzel) & [Rofi](https://github.com/davatorium/rofi) |
| **Lockscreen** | [Hyprlock](https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/) |
| **Idle Daemon** | [Hypridle](https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/) |
| **Notifications** | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) |
| **Audio (CLI)** | [ncspot](https://github.com/hrkfdn/ncspot) (Spotify client) |
| **UI Custom** | [Quickshell](https://github.com/outfoxxed/quickshell) (Menus QML) |

## 📁 Structure des fichiers clés

- `hyprland.conf` : Cœur de la configuration (raccourcis, règles de fenêtres, gestion multi-écrans).
- `hyprlock.conf` : Verrouillage d'écran avec format de date stylisé.
- `config.toml` (ncspot) : Interface musicale entièrement thématisée Gruvbox.
- `*.qml` : Menus interactifs pour le Wi-Fi et les options d'alimentation.
- `config.jsonc` (fastfetch) : Résumé système élégant à l'ouverture du terminal.

## ⌨️ Raccourcis Utiles (Keybindings)

Le `SUPER` (touche Windows) est la touche modificatrice principale :

- **SUPER + Q** : Lancer le terminal (**Kitty**)
- **SUPER + E** : Explorateur de fichiers (**Thunar**)
- **SUPER + R** : Lanceur d'applications (**Fuzzel**)
- **ALT + F4** : Menu d'alimentation personnalisé (**Quickshell**)
- **SUPER + L** : Verrouiller l'écran immédiatement
- **Touches Multimédia** : Contrôle complet du volume et de la musique via `playerctl` et `pactl`.

## 🎨 Palette de couleurs (Gruvbox Dark)

Les composants utilisent les codes couleurs suivants pour assurer la continuité visuelle :
- **Background** : `#282828` / `#1d2021`
- **Foreground** : `#ebdbb2`
- **Accent (Orange)** : `#fe8019`
- **Success (Green)** : `#b8bb26`
- **Selection** : `#3c3836`

## 🚀 Installation

1. **Cloner le dépôt** :
   ```bash
   git clone [https://github.com/ton-pseudo/dotfiles.git](https://github.com/ton-pseudo/dotfiles.git)
   cd dotfiles

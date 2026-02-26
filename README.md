# 🚀 Arch Hyprland Dev Setup

Bienvenue dans ma configuration personnelle. Il s'agit d'un environnement **Arch Linux** optimisé pour le **développement**, utilisant **Hyprland** comme gestionnaire de fenêtres. L'accent est mis sur l'esthétique (thématisation dynamique avec Matugen), la performance et un workflow fluide.

## 🛠 Environnement de base
- **Distribution :** [Arch Linux](https://archlinux.org/)
- **Window Manager :** [Hyprland](https://hyprland.org/) (Dynamic Tiling Wayland Compositor)
- **Barre d'état :** [Waybar](https://github.com/Alexays/Waybar) (Hautement personnalisable)
- **Notifications :** [SwayNotificationCenter](https://github.com/ErikReider/SwayNotificationCenter) (SwayNC)

---

## 💻 Dépendances & Outils Core

Pour reproduire cet environnement, les outils suivants sont nécessaires :

### Terminaux & Shell
- **Terminaux :** [Kitty](https://sw.kovidgoyal.net/kitty/) & [Ghostty](https://ghostty.org/)
- **Éditeur de texte :** [NvChad](https://nvchad.com/) (Configuration Neovim ultra-rapide)
- **Gestionnaire de fichiers :** [Yazi](https://github.com/sxyazi/yazi) (Terminal file manager)

### Interface & Esthétique
- **Shell UI :** [Quickshell](https://github.com/outfoxxed/quickshell) (Utilisé pour le Dashboard, la barre et les menus QML)
- **Lanceur d'applications :** [Rofi (Wayland fork)](https://github.com/davatorium/rofi) & [Fuzzel](https://codeberg.org/dnkl/fuzzel)
- **Génération de couleurs :** [Matugen](https://github.com/InioX/matugen) (Génère des palettes de couleurs à partir de tes fonds d'écran)
- **Login Manager :** [SDDM](https://github.com/sddm/sddm)
- **Fetch :** [Fastfetch](https://github.com/fastfetch-cli/fastfetch)

### Multimédia & Utilitaires
- **Musique :** [ncspot](https://github.com/hrkfdn/ncspot) (Client Spotify pour terminal)
- **Gestion du verrouillage :** [Hyprlock](https://github.com/hyprwm/hyprlock) & [Hypridle](https://github.com/hyprwm/hypridle)

---

## 🎨 Personnalisation (Dots Highlights)

### 🌈 Shaders GLSL
Ma config inclut une collection massive de **shaders GLSL** utilisables avec Hyprland ou Kitty pour des effets visuels avancés :
- Effets CRT et Rétro-terminal.
- Arrières-plans animés (Galaxy, Matrix, Water, Fireworks).
- Effets de curseur (Warp, Blaze).

### 🖼 Gestion des Wallpapers
Le dossier `walls/` contient des thèmes spécifiques :
- **Akane :** Une esthétique rouge/sombre.
- **Gruvbox :** Le classique rétro-moderne.
- **Osaka Jade :** Des tons verts apaisants.

### ⚙️ Automatisation avec Matugen
Les templates dans `matugen/templates` permettent de synchroniser automatiquement les couleurs de **Kitty**, **Rofi** et **Waybar** dès que le fond d'écran est changé via les scripts de sélection présents dans `rofi/`.

---

## 📂 Structure du dépôt
```text
.
├── hypr/          # Logique du Window Manager
├── quickshell/    # Composants QML (Bar, Dashboard, Panels)
├── matugen/       # Templates de couleurs dynamiques
├── shaders/       # Shaders de post-process visuel
├── waybar/        # Configuration de la barre système
└── walls/         # Ma collection de fonds d'écran

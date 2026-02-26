# 🌌 Arch Hyprland • Dev Environment

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="400">
</p>

---

## 📂 System Overview

| OS | WM | Shell | Editor | Theme |
| :---: | :---: | :---: | :---: | :---: |
| 🟦 **Arch** | 🧊 **Hyprland** | 🐚 **Zsh** | ⚡ **NvChad** | 🎨 **Matugen** |

---

## 🛠️ Core Components

> [!IMPORTANT]
> Cette configuration est un environnement de **développement pur**, axé sur la productivité au clavier et l'esthétique dynamique.

### 🖥️ Window Management & UI
* **Window Manager** ➜ [Hyprland](https://hyprland.org/) `(Wayland)`
* **Status Bar** ➜ [Waybar](https://github.com/Alexays/Waybar) `(Custom CSS)`
* **Application Launcher** ➜ [Rofi-Wayland](https://github.com/davatorium/rofi) & [Fuzzel](https://codeberg.org/dnkl/fuzzel)
* **Notification Center** ➜ [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
* **Interactive UI** ➜ [Quickshell](https://github.com/outfoxxed/quickshell) `(Dashboard & Panels QML)`

### ⌨️ Terminal & Dev Tools
* **Terminal Emulator** ➜ [Kitty](https://sw.kovidgoyal.net/kitty/) & [Ghostty](https://ghostty.org/)
* **IDE (Neovim)** ➜ [NvChad](https://nvchad.com/) `(Blazing Fast)`
* **File Manager** ➜ [Yazi](https://github.com/sxyazi/yazi) `(Terminal-based)`
* **System Fetch** ➜ [Fastfetch](https://github.com/fastfetch-cli/fastfetch)

---

## 🎨 Aesthetic & Themes

### 🖼️ Wallpapers & Colors
La gestion des couleurs est **dynamique** via [Matugen](https://github.com/InioX/matugen). Les thèmes inclus sont :
* `🟥 Akane` : Dark & Crimson.
* `🟫 Gruvbox` : Retro cozy vibes.
* `🟩 Osaka Jade` : Clean & Organic.

### 🎭 GLSL Shaders
Des shaders custom sont appliqués sur l'ensemble de l'interface pour un look unique :
* `✨ bloom.glsl` : Effet de lueur douce.
* `📺 crt.glsl` : Rendu écran cathodique vintage.
* `❄️ just-snow.glsl` : Particules atmosphériques.

---

## 📦 Music & Lock
* **Music Player** ➜ [ncspot](https://github.com/hrkfdn/ncspot) `(Spotify TUI)`
* **Lockscreen** ➜ [Hyprlock](https://github.com/hyprwm/hyprlock)
* **Idle Daemon** ➜ [Hypridle](https://github.com/hyprwm/hypridle)
* **Display Manager** ➜ [SDDM](https://github.com/sddm/sddm)

---

## 🚀 Installation Quick-Look

```bash
# Clone the setup
git clone [https://github.com/ton-pseudo/dotfiles.git](https://github.com/ton-pseudo/dotfiles.git)

# Symlink configs (example)
ln -s ~/dotfiles/hypr ~/.config/hypr

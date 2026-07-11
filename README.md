# 🌌 Hyprland • Dev Environment

<div align="center">

[![Donate](https://img.shields.io/badge/Ko--fi-Donate-f38ba8?style=for-the-badge)](https://ko-fi.com/dankdown)

</div>

### 🖥️ OS Overview
<div align="center">

![OS](https://img.shields.io/badge/OS-Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![WM](https://img.shields.io/badge/WM-Hyprland-33ccff?style=for-the-badge&logo=hyprland&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Zsh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Editor](https://img.shields.io/badge/Editor-NvChad-98C379?style=for-the-badge&logo=neovim&logoColor=white)
![Design](https://img.shields.io/badge/Design-Matugen-fab387?style=for-the-badge)

</div>

---

## 🎬 Showcase
[#See it here](showcase_hyprland.mp4)
---

## 🛠️ Core Components

> [!IMPORTANT]
> Cet environnement est une **Workstation de développement** optimisée pour la vitesse, le tiling et l'esthétique dynamique.

### 🖥️ Window Management & UI
* **Window Manager** ➜ [Hyprland](https://github.com/hyprwm/Hyprland) `(Wayland)`
* **Status Bar** ➜ [Waybar](https://github.com/Alexays/Waybar) `(Custom CSS)`
* **Notification Center** ➜ [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
* **Interactive UI** ➜ [Quickshell](https://github.com/outfoxxed/quickshell) `(QML Panels)`
* **Application Launcher** ➜ [Rofi-Wayland](https://github.com/davatorium/rofi) & [Fuzzel](https://github.com/dnkl/fuzzel)

### ⌨️ Terminal & Dev Tools
* **Terminals** ➜ [Kitty](https://github.com/kovidgoyal/kitty) & [Ghostty](https://github.com/ghostty-org/ghostty)
* **IDE (Neovim)** ➜ [NvChad](https://github.com/NvChad/NvChad) `(Blazing Fast)`
* **File Manager** ➜ [Yazi](https://github.com/sxyazi/yazi) `(TUI)`
* **System Fetch** ➜ [Fastfetch](https://github.com/fastfetch-cli/fastfetch)

---

## 🎨 Aesthetic & Themes

### 🌈 Matugen Integration
La palette de couleurs (Kitty, Rofi, Waybar) est générée dynamiquement via [Matugen](https://github.com/InioX/matugen).

### 🎭 Custom Shaders
Une collection massive de shaders `.glsl` (situés dans `shaders/`) permet de transformer le rendu visuel :
* `📺 crt.glsl` • `✨ bloom.glsl` • `❄️ just-snow.glsl` • `🌌 galaxy.glsl`

---

## 📦 Multimedia & Utilities
* **Music** ➜ [ncspot](https://github.com/hrkfdn/ncspot) `(Spotify TUI)`
* **Lockscreen** ➜ [Hyprlock](https://github.com/hyprwm/hyprlock)
* **Idle Daemon** ➜ [Hypridle](https://github.com/hyprwm/hypridle)
* **Login Manager** ➜ [SDDM](https://github.com/sddm/sddm)

---

## 🚀 Quick Start

```bash
#Dependencies
sudo pacman -S hyprland hypridle hyprlock waybar swaync dunst pavucontrol nwg-look lxappearance matugen python-pywal ghostty yazi fastfetch
yay -S hyprpanel aylurs-gtk-shell hyprshade hyprshot hyprfindr hyprquickframe-git hyprmode waypaper swww avizo pimpmyrice greenclip bemoji bibata-cursor-gruvbox-git sweet-cursors-hyprcursor-git vimix-kanagawa-hyprcursors gruvbox-material-gtk-theme-git clock-rs-git wallhaven-cli

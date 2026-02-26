# 🌌 Arch Hyprland • Dev Environment

<div align="center">

![Last Commit](https://img.shields.io/badge/Last_Commit-Last_Tuesday-8fbcbb?style=for-the-badge)
![Stars](https://img.shields.io/badge/Stars-7.7k-b4befe?style=for-the-badge)
![Repo Size](https://img.shields.io/badge/Repo_Size-2.8_MiB-cba6f7?style=for-the-badge)
![Donate](https://img.shields.io/badge/Ko--fi-Donate-f38ba8?style=for-the-badge)
![Discord](https://img.shields.io/badge/Discord-458-94e2d5?style=for-the-badge)

</div>

---

## 📂 System Overview

| OS | WM | Shell | Editor | Theme |
| :---: | :---: | :---: | :---: | :---: |
| 🟦 **Arch** | 🧊 **Hyprland** | 🐚 **Zsh** | ⚡ **NvChad** | 🎨 **Matugen** |

---

## 🛠️ Core Components

> [!IMPORTANT]
> Cet environnement est une **Workstation de développement** optimisée pour la vitesse, le tiling et l'esthétique dynamique.

### 🖥️ Window Management
* **Window Manager** ➜ [Hyprland](https://hyprland.org/) `(Wayland)`
* **Status Bar** ➜ [Waybar](https://github.com/Alexays/Waybar) `(Custom CSS)`
* **Notification Center** ➜ [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
* **Interactive UI** ➜ [Quickshell](https://github.com/outfoxxed/quickshell) `(QML Panels)`

### ⌨️ Terminal & Dev Tools
* **Terminals** ➜ [Kitty](https://sw.kovidgoyal.net/kitty/) & [Ghostty](https://ghostty.org/)
* **IDE (Neovim)** ➜ [NvChad](https://nvchad.com/) `(Config pré-configurée)`
* **File Manager** ➜ [Yazi](https://github.com/sxyazi/yazi) `(TUI)`
* **Application Launcher** ➜ [Rofi-Wayland](https://github.com/davatorium/rofi)

---

## 🎨 Aesthetic & Themes

### 🌈 Matugen Integration
Les couleurs de l'ensemble du système (Kitty, Rofi, Waybar) s'adaptent dynamiquement grâce à [Matugen](https://github.com/InioX/matugen).

### 🎭 Custom Shaders
Une large collection de shaders `.glsl` est incluse pour transformer ton affichage :
* `📺 crt.glsl` • `✨ bloom.glsl` • `❄️ just-snow.glsl` • `🌌 galaxy.glsl`

---

## 📦 Multimedia & Utilities
* **Music** ➜ [ncspot](https://github.com/hrkfdn/ncspot) `(Spotify TUI)`
* **Lockscreen** ➜ [Hyprlock](https://github.com/hyprwm/hyprlock)
* **Idle Daemon** ➜ [Hypridle](https://github.com/hyprwm/hypridle)
* **Login Manager** ➜ [SDDM](https://github.com/sddm/sddm)

---

## 🚀 Installation

```bash
# Les dépendances principales sur Arch
sudo pacman -S hyprland waybar kitty rofi-wayland sddm matugen-bin yazi fastfetch

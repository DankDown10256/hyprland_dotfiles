# Hyprland dotfiles

A compact Hyprland desktop configuration for Arch Linux, with an i3-style workflow, a themed lock screen, a minimal Waybar, SwayNC notifications, and Kitty.

## Included configuration

| Component | Configuration |
| --- | --- |
| Hyprland | French keyboard layout, tiling, animated transitions, blur, window rules, and i3-style navigation |
| Hypridle | Locks the session after 10 minutes and before sleep |
| Hyprlock | Blurred session screenshot, clock, date, identity, and password field |
| Waybar | Workspaces, clock, network, volume, memory, and battery |
| SwayNC | Top-centered notification center with grouping and Do Not Disturb |
| Kitty | JetBrainsMono Nerd Font, dark palette, tabs, scrollback, and keyboard shortcuts |
| Hyprland shaders | CRT, focus, invert-color, reading-mode, and display-enhancement shaders |

The active Hyprland setup starts PipeWire, WirePlumber, `awww-daemon`, Hypridle, SwayNC, Udiskie, and Waybar. It uses Kitty as the terminal, Nautilus as the file manager, and Rofi as the application launcher.

## Repository layout

```text
configs/
├── hypr/       Hyprland, Hypridle, Hyprlock, shaders, and helper scripts
├── kitty/      Kitty configuration and color themes
├── swaync/     Notification center configuration and stylesheet
└── waybar/     Status bar configuration and stylesheet
```

The `configs/hypr/shaders/` directory also contains an alternative Hyprland and Hyprlock setup alongside the shader collection.

## Main key bindings

| Shortcut | Action |
| --- | --- |
| `Super + Enter` | Open Kitty |
| `Super + Space` | Open Rofi |
| `Super + E` | Open Nautilus |
| `Super + Q` | Close the active window |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating mode |
| `Super + L` | Lock the session |
| `Super + N` | Toggle SwayNC |
| `Super + Arrow` | Move focus |
| `Super + Shift + Arrow` | Move the active window |
| `Super + 1–0` | Switch to workspace 1–10 |
| `Super + Shift + 1–0` | Move the active window to workspace 1–10 |
| `Super + Ctrl + Arrow` | Resize the active window |
| `Super + S` | Toggle the special workspace |

## Requirements

Install the applications referenced by the configuration before enabling it:

```bash
sudo pacman -S hyprland hypridle hyprlock kitty waybar swaync rofi-wayland nautilus pipewire pipewire-pulse wireplumber udiskie brightnessctl libnotify jq curl playerctl imagemagick
```

Additional commands referenced by the configuration are `awww-daemon`, `hyprquickframe`, `featherpad`, `imv`, and the Rofi scripts expected under `~/.config/rofi/`.

A Nerd Font is required for the icons. The Kitty and Hyprlock configurations expect JetBrainsMono Nerd Font.

## Installation

Back up any existing configuration, then copy or symlink only the components you want to use:

```bash
mkdir -p ~/.config/hypr ~/.config/kitty ~/.config/swaync ~/.config/waybar

cp -r configs/hypr/. ~/.config/hypr/
cp -r configs/kitty/. ~/.config/kitty/
cp -r configs/swaync/. ~/.config/swaync/
cp -r configs/waybar/. ~/.config/waybar/
```

Review the monitor definitions, cursor theme, program paths, and autostart commands in `configs/hypr/hyprland.conf` before starting Hyprland. The current monitor setup mirrors `HDMI-A-2` to `eDP-1`.

Make the helper scripts executable after copying them:

```bash
chmod +x ~/.config/hypr/scripts/*.sh
```

## Helper scripts

- `blitz-mode.sh` toggles Hyprland animations and visual effects.
- `github_graph.sh` downloads a GitHub contribution graph for Hyprlock.
- `hyprlock-layout.sh` reports the active keyboard layout.
- `hyprlock-music.sh` exposes MPRIS track metadata and prepares album artwork.
- `hyprlock_weather.sh` displays weather and battery information.

Some helper scripts contain user-specific paths or values. Review them before use, especially the GitHub username, battery device, wallpaper path, and Hyprlock script paths.

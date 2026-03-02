# Purple Minimal - i3-gaps Desktop Environment

A clean, minimal i3-gaps desktop environment with a purple/violet color scheme. Designed for LMDE 7 (Linux Mint Debian Edition) on a MacBook Pro 2015.

Inspired by [u/muvoksi's r/unixporn setup](https://www.reddit.com/r/unixporn/) - a beautiful purple-themed tiling window manager environment with translucent terminals, polybar, rofi, and a cohesive dark violet aesthetic.

---

## Color Palette

| Element        | Color     |
|----------------|-----------|
| Background     | `#2f1e2e` |
| Foreground     | `#a39e9b` |
| Black          | `#1b1b1b` |
| Red            | `#ef6155` |
| Green          | `#48b685` |
| Yellow         | `#fec418` |
| Blue           | `#06b6ef` |
| Magenta        | `#815ba4` |
| Cyan           | `#5bc4bf` |
| White          | `#d0d0d0` |
| Focused border | `#9928b5` |
| Active border  | `#7b218f` |
| Accent green   | `#96e61e` |

---

## Packages

The following packages are installed by `install.sh`:

### Core
| Package                  | Purpose                            |
|--------------------------|------------------------------------|
| `i3`                     | Tiling window manager (gaps merged in 4.22+) |
| `polybar`                | Status bar                         |
| `picom`                  | Compositor (shadows, fading, vsync) |
| `rofi`                   | Application launcher               |
| `alacritty`              | GPU-accelerated terminal emulator  |
| `dunst`                  | Notification daemon                |
| `feh`                    | Wallpaper setter                   |

### Utilities
| Package                  | Purpose                            |
|--------------------------|------------------------------------|
| `playerctl`              | MPRIS media player control         |
| `pulseaudio-utils`       | Volume control (pactl)             |
| `pavucontrol`            | PulseAudio GUI mixer               |
| `brightnessctl`          | Screen brightness control          |
| `scrot`                  | Screenshot utility                 |
| `i3lock`                 | Screen locker                      |
| `neofetch`               | System information display         |
| `network-manager-gnome`  | Network manager tray applet        |
| `policykit-1-gnome`      | Authentication dialog agent        |

### Fonts
| Package                  | Purpose                            |
|--------------------------|------------------------------------|
| `fonts-roboto`           | UI font (i3, polybar)              |
| `fonts-font-awesome`     | Icon font (polybar, i3 workspaces) |
| RobotoMono (Nerd Font)   | Terminal font (auto-downloaded)    |
| Source Code Pro           | Rofi font (auto-downloaded)        |

### Theming
| Package                  | Purpose                            |
|--------------------------|------------------------------------|
| `papirus-icon-theme`     | Icon theme for rofi and dunst      |

---

## File Structure

```
DE3-i3gaps-purple/
├── config/
│   ├── i3/
│   │   └── config              # i3 window manager config
│   ├── polybar/
│   │   ├── config.ini          # Polybar status bar config
│   │   └── launch.sh           # Polybar launcher script
│   ├── picom/
│   │   └── picom.conf          # Compositor config
│   ├── rofi/
│   │   └── config.rasi         # Application launcher theme
│   ├── alacritty/
│   │   └── alacritty.toml      # Terminal emulator config
│   ├── dunst/
│   │   └── dunstrc             # Notification daemon config
│   └── neofetch/
│       └── config.conf         # System info display config
├── .Xresources                 # X11 resource definitions
├── install.sh                  # Automated installer
└── README.md                   # This file
```

---

## Installation

### Quick Install

```bash
cd DE3-i3gaps-purple
chmod +x install.sh
./install.sh
```

The installer will:
1. Update apt package lists
2. Install all required packages
3. Download and install RobotoMono and Source Code Pro fonts
4. Back up any existing configs to `~/.config/purple-minimal-backup-TIMESTAMP/`
5. Deploy all configuration files to `~/.config/`
6. Set correct file permissions

### Manual Install

If you prefer to install manually:

```bash
# Install packages
sudo apt install i3 polybar picom rofi alacritty dunst feh neofetch \
    playerctl pulseaudio-utils pavucontrol brightnessctl scrot i3lock \
    fonts-roboto fonts-font-awesome network-manager-gnome \
    policykit-1-gnome papirus-icon-theme x11-xserver-utils

# Copy configs
cp -r config/i3 ~/.config/
cp -r config/polybar ~/.config/
cp -r config/picom ~/.config/
cp -r config/rofi ~/.config/
cp -r config/alacritty ~/.config/
cp -r config/dunst ~/.config/
cp -r config/neofetch ~/.config/
cp .Xresources ~/

# Make polybar launcher executable
chmod +x ~/.config/polybar/launch.sh
```

### Post-Install

1. **Set a wallpaper**: Place your wallpaper at `~/Pictures/wallpaper.jpg`
   - Recommended: dark purple/violet abstract or landscape image
2. **Log out** of your current session
3. **Select i3** as your window manager at the login screen
4. **Log in** and enjoy

---

## Keybindings

`Mod` = Super key (Command key on MacBook)

### Applications
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + Return`       | Open terminal (Alacritty) |
| `Mod + d`            | Open app launcher (Rofi)  |
| `Mod + Shift + q`    | Close focused window      |

### Focus
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + h/j/k/l`     | Focus left/down/up/right  |
| `Mod + Arrow keys`   | Focus left/down/up/right  |
| `Mod + a`            | Focus parent container    |
| `Mod + Shift + a`    | Focus child container     |

### Move Windows
| Keybinding              | Action                      |
|-------------------------|-----------------------------|
| `Mod + Shift + h/j/k/l` | Move left/down/up/right    |
| `Mod + Shift + Arrows`  | Move left/down/up/right    |

### Layout
| Keybinding           | Action                     |
|----------------------|----------------------------|
| `Mod + b`            | Split horizontal           |
| `Mod + v`            | Split vertical             |
| `Mod + f`            | Toggle fullscreen          |
| `Mod + s`            | Stacking layout            |
| `Mod + w`            | Tabbed layout              |
| `Mod + e`            | Toggle split               |
| `Mod + Shift + Space`| Toggle floating            |
| `Mod + Space`        | Toggle focus float/tile    |

### Workspaces
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + 1-5`         | Switch to workspace 1-5   |
| `Mod + Shift + 1-5` | Move window to workspace  |

### Gaps
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + g`            | Increase inner gaps       |
| `Mod + Shift + g`    | Decrease inner gaps       |
| `Mod + Ctrl + g`     | Reset gaps to default     |

### Resize Mode
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + r`            | Enter resize mode         |
| `h/j/k/l` or arrows | Resize in mode            |
| `Escape` or `Return` | Exit resize mode         |

### Scratchpad
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + Shift + -`   | Move to scratchpad        |
| `Mod + -`            | Show scratchpad           |

### Media
| Keybinding             | Action                  |
|------------------------|-------------------------|
| `XF86AudioRaiseVolume` | Volume up               |
| `XF86AudioLowerVolume` | Volume down             |
| `XF86AudioMute`        | Toggle mute             |
| `XF86AudioPlay`        | Play/Pause              |
| `XF86AudioNext`        | Next track              |
| `XF86AudioPrev`        | Previous track          |
| `XF86MonBrightnessUp`  | Brightness up           |
| `XF86MonBrightnessDown`| Brightness down         |

### Screenshots
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Print`              | Full screenshot           |
| `Mod + Print`        | Selection screenshot      |

### Session
| Keybinding           | Action                    |
|----------------------|---------------------------|
| `Mod + Shift + c`   | Reload i3 config          |
| `Mod + Shift + r`   | Restart i3                |
| `Mod + Shift + e`   | Exit i3                   |
| `Mod + Shift + x`   | Lock screen               |

---

## Components

### i3 (Window Manager)
- Gaps: 12px inner, 0px outer (adjustable with `Mod+g`)
- Pixel borders (2px) with purple color scheme
- FontAwesome workspace icons on workspaces 1-2
- Chrome auto-assigned to workspace 2
- Focus follows mouse

### Polybar (Status Bar)
- Top bar, 36px height
- Semi-transparent purple background
- Left: window title
- Center: i3 workspace indicators with underline
- Right: CPU, memory, volume, date/time, power menu
- System tray on the right side

### Picom (Compositor)
- GLX backend for smooth rendering
- Shadows with 7px offset (muvoksi's style)
- Fade animations (0.03 step, 5ms delta)
- VSync enabled
- 6px corner radius on windows

### Rofi (Launcher)
- Dark purple/charcoal theme
- Teal accent (`#13bf9d`) for selected items
- Source Code Pro Semibold font
- Application icons via Papirus-Dark
- 8-item scrollable list with search

### Alacritty (Terminal)
- 80% opacity (translucent background matching muvoksi's style)
- RobotoMono Medium font at size 10
- 10px internal padding
- Full purple color scheme
- Block cursor with blink

### Dunst (Notifications)
- Purple-themed notification popups
- 6px corner radius
- Purple border (varies by urgency level)
- Papirus-Dark icons
- Top-right positioning

### Neofetch
- Minimal info display (OS, kernel, uptime, WM, CPU, GPU, memory)
- Purple accent colors (color 5)

---

## MacBook Pro 2015 Notes

- **Super key** = Command key (left of spacebar)
- **Brightness keys** are mapped via `brightnessctl`
- **Volume/media keys** work via `pactl` and `playerctl`
- **Function keys** may require `fnmode` kernel parameter adjustment
- If trackpad is not working, install `xserver-xorg-input-libinput` or `xserver-xorg-input-mtrack`

---

## Customization

### Change wallpaper
Edit the `feh` line in `~/.config/i3/config`:
```
exec_always --no-startup-id feh --bg-fill ~/Pictures/your-wallpaper.jpg
```

### Adjust transparency
Edit `opacity` in `~/.config/alacritty/alacritty.toml`:
```toml
[window]
opacity = 0.85  # 0.0 = fully transparent, 1.0 = opaque
```

### Adjust gaps
Edit gaps in `~/.config/i3/config`:
```
gaps inner 12
gaps outer 0
```
Or use `Mod+g` / `Mod+Shift+g` at runtime.

---

## Credits

- **Original inspiration**: u/muvoksi's Purple Minimal setup on [r/unixporn](https://www.reddit.com/r/unixporn/)
- **i3-gaps**: Originally by Airblader, now merged into [i3wm](https://i3wm.org/)
- **Color palette**: Based on the Paraiso Dark theme family
- **Fonts**: [Roboto](https://fonts.google.com/specimen/Roboto) by Google, [Font Awesome](https://fontawesome.com/), [Nerd Fonts](https://www.nerdfonts.com/)

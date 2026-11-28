# NixOS-dotfiles
Custom configuration for Hyprland and NixOS

Per device configurations are under hosts. I currently only have configured one device (a L13 Thinkpad) with NixOS, but I have plans to attempt to run NixOS on a 2013 Mac Pro as a home gaming device, and for running headless VMs.

Hyprland and waybar configurations are included. Install your own wallpaper and configure Hyprpaper or your wallpaper manager of choice.

At the time of writing, the rose-pine theme was in use, but I expect to change it and forget to update.

# Showcase
<img src="https://github.com/user-attachments/assets/e2686426-5776-43f2-93c1-97b45bd159cc" />

## Install
Run the following commands from your home directory to install the template configuration on your device with all modules enabled.

```
git clone https://github.com/tory-n/NixOS-dotfiles

cd NixOS-dotfiles
cp /etc/nixos/hardware-configuration.nix ./hosts/template/hardware-configuration.nix
git add hosts/template/hardware-configuration.nix
# if the above fails
nixos-generate-config --show-hardware-config > hosts/template/hardware-configuration.nix

sudo nixos-rebuild switch --flake ".#user"
```

## REMEMBER TO RUN PASSWD ON FIRST LOGIN. 

The default password is "changeme". CHANGE IT.

## Other things to take note of

/home/hyprland-home has a device-specific power control added. Change it for your own device.

## What I've done

### Waybar
 Config based on itsfoss' polybar config.
 
 #### Functions
 - Workspace indicator (clickable, the workspace indicator turns red if an app there opens a new window)
 - Volume and brightness indicators (changable with scroll wheel)
 - Clock (clickable to reveal date)
 - Current app name (now playing and cava removed)
 - RAM, CPU and storage (shown as `/xx%`) indicators
 - Systray, autostart should include bitwarden, vicinae, fcitx and wifi (nm-applet)
 - Battery indicator
 - Power menu
### Hyprland
bspwm/sxhkd-like configuration
#### Keybinds and Gestures

| Mod       | Bind                     | Action                               |
| --------- | ------------------------ | ------------------------------------ |
| `Super +` | `Return`                 | Kitty                                |
| `Super +` | `F`                      | Nautilus                             |
| `Super +` | `W`                      | Zen                                  |
| `Super +` | `Space`                  | Vicinae                              |
| `Super +` | `Q`                      | CLose window                         |
| `Super +` | `Shift + Q`              | Exit Hyprland                        |
| `Super +` | `S`/`Shft+S`             | Float/Pseudo-tile                    |
| `Super +` | `R`                      | Toggle split in dwindle view         |
| `Super +` | `M`                      | Minimise (send to hidden workspace)  |
| `Super +` | `CTRL + R`               | Reload Hyprland (redundant)          |
| `Super +` | `Arrow Keys`             | Change focus                         |
| `Super +` | `1` to `0`               | Go to workspace                      |
| `Super +` | `Scroll`                 | Cycle through workspaces             |
|           | `PrtScr`                 | Screenshot to clipboard              |
| `Super +` | `PrtScr`                 | Screenshot whole screen to clipboard |
| `Super +` | `Left Drag`/`Right Drag` | Move/Resize                          |

| Gesture                     | Action                          |
| --------------------------- | ------------------------------- |
| `4-finger horizontal swipe` | Switch workspace                |
| `3-finger horizontal swipe` | Scrolling layout                |
| `4-finger vertical swipe`   | Show Hyprspace (non-functional) |

### Tools (non-exhaustive)

| Category        | Tool                                              | Config included |                                     |
| --------------- | ------------------------------------------------- | --------------- | ----------------------------------- |
| Session/Desktop | UWSM                                              | Yes             |                                     |
|                 | ly                                                | Yes             |                                     |
|                 | hyprlock                                          | Soon            |                                     |
|                 | hypridle                                          | Yes             |                                     |
|                 | hyprpaper                                         | No              |                                     |
|                 | waybar                                            | Yes             |                                     |
|                 | mako                                              | Yes             |                                     |
|                 | vicinae                                           | No              | (complicated)                       |
|                 | polkit-gnome                                      |                 |                                     |
| Shell/Dev       | kitty                                             | No              |                                     |
|                 | fish                                              | Soon            | Functions only                      |
|                 | git                                               | No              |                                     |
|                 | fastfetch                                         | No              |                                     |
|                 | fetch (areofyl)                                   | No              |                                     |
| Utility         | grim                                              | N/A             |                                     |
|                 | slurp                                             | N/A             |                                     |
|                 | brightnessctl                                     | N/A             |                                     |
|                 | pavucontrol                                       | N/A             |                                     |
|                 | nm-applet                                         | N/A             |                                     |
|                 | blueman                                           | N/A             |                                     |
|                 | fcitx5 (English, Japanese and Simplified Chinese) | Yes             |                                     |
| Files           | Owly                                              | Soon            | Shortcut onfigured as fish function |
|                 | Localsend                                         | No              |                                     |
|                 | Nautilus                                          | No              |                                     |
| Apps            | Obsidian                                          | No              |                                     |
|                 | Discord                                           | No              |                                     |
|                 | Zen Browser                                       | No              |                                     |
|                 | Firefox                                           | No              | (Fallback)                          |
|                 | Kew                                               | No              |                                     |
|                 | Spotify                                           | No              |                                     |
|                 | VLC                                               | No              |                                     |
|                 | OBS                                               | No              |                                     |
|                 | OnlyOffice                                        | No              |                                     |
|                 | Bitwarden                                         | No              |                                     |
| Music Creation  | Musnix                                            | No              |                                     |
|                 | REAPER                                            | No              |                                     |
|                 | Carla                                             | No              |                                     |
|                 | LSP                                               | No              |                                     |
|                 | Calf                                              | No              |                                     |
|                 | Surge XT                                          | No              |                                     |
|                 | Vital                                             | No              |                                     |
|                 | Odin2                                             | No              |                                     |
|                 | Zan                                               | No              |                                     |
|                 | sfizz                                             | No              |                                     |
|                 | NAM                                               | No              |                                     |
|                 | mda                                               | No              |                                     |
|                 | Decent Sampler                                    | No              |                                     |
|                 | Musescore                                         | No              |                                     |
|                 | Septabee                                          | No              |                                     |
| Theming         | Rose Pine (currently)                             | Yes             |                                     |
|                 | Bibata Cursor                                     | Yes             |                                     |
|                 | LINE Seed JP                                      | Yes             |                                     |
|                 | Google Sans Code                                  | Yes             |                                     |
| Fun             | cmatrix                                           | N/A             |                                     |
|                 | cbonsai                                           | N/A             |                                     |
|                 | pipes.sh                                          | N/A             |                                     |
N/A

# Configuration
Configuration instructions can be found as comments within /hosts/template/ files.
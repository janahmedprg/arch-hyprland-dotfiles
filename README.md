## Arch Hyperland Setup

### Install Packages

Run the following to install necessary packages:

```
cd arch-hyprland-dotfiles
sudo pacman -S --needed - < packages.txt
yay -S --needed - < aur_packages.txt
```

### Rofi add custom app
Create applications folder if it doesn't exist:
```
mkdir -p ~/.local/share/applications
vim ~/.local/share/applications/rofi-emoji.desktop
```
Paste:
```
[Desktop Entry]
Type=Application
Name=Emoji Picker
Comment=Pick and copy emojis using rofi
Exec=rofi -modi emoji -show emoji
Icon=face-smile
Terminal=false
Categories=Utility;
```

Update cache:
```
update-desktop-database ~/.local/share/applications
```
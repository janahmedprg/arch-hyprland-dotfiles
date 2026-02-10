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

Discord app:
```
[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=/usr/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
Icon=discord
Type=Application
Categories=Network;InstantMessaging;
Path=/usr/bin
MimeType=x-scheme-handler/betterdiscord;
```
Rofi calc:
```
[Desktop Entry]
Type=Application
Name=Calculator
Comment=Do live calculations
Exec=rofi -modi calc -show calc -calc-command "echo '{result}' | wl-copy && hyprctl dispatch sendshortcut CTRL, V, activewindow"
Icon=accessories-calculator
Terminal=false
Categories=Utility;
Keywords=calc;math;calculator;
```
Clipboard:
```
[Desktop Entry]
Type=Application
Name=Clipboard
Comment=Paste from clipboard history
Exec=/home/janahmed/.local/bin/paste-clipboard
Icon=edit-paste
Terminal=false
Categories=Utility;
Keywords=clipboard;copy;paste;
```

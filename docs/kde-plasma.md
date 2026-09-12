# KDE Plasma Setup

## Packages

### KDE / Desktop

```bash
sudo pacman -S \
  plasma-desktop \
  sddm sddm-kcm \
  plasma-nm plasma-pa \
  kscreen powerdevil \
  breeze breeze-gtk bluedevil \
  xdg-desktop-portal-kde \
  dolphin konsole spectacle ark gwenview
````

### Audio

```
sudo pacman -S \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  wireplumber
```

### Other Applications

```
sudo pacman -S \
  ffmpegthumbs \
  mpv \
  okular \
  libreoffice-fresh
```

## KDE User

- Avatar: avatar.png\
  `System Settings → System → Users → Your Account`

## KDE Theme & Wallpaper

- Global Theme: **Breeze Dark**\
  `System Settings → Appearance & Style → Global Theme`
- Desktop Wallpaper: plasma-desktop.png\
  `System Settings → Appearance & Style → Wallpaper`
- Lock Screen Wallpaper: plasma-lockscreen.png\
  `System Settings → Security & Privacy → Screen Locking`

## KDE Default Bottom Panel

`Right-click Panel → Show Panel Configuration`

- Pager: Not present
- Task Manager: Running applications only
  - Pinned applications: None

 ## SDDM Theme

`System Settings → Colors & Themes → Login Screen (SDDM)`

- Theme: **Breeze**
  - Background: sddm-login.png

## Mouse

`System Settings → Input & Output → Mouse & Touchpad`

- Pointer speed: `0.20`
- Invert scroll direction (Natural scrolling): Enabled
```

```

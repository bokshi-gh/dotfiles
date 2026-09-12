# KDE Plasma Setup

## Packages

### KDE / Desktop

```bash
sudo pacman -S \
  plasma-desktop \
  sddm sddm-kcm \
  plasma-nm plasma-pa \
  powerdevil \
  breeze breeze-gtk bluedevil \
  dolphin konsole spectacle ark gwenview \
  ffmpegthumbs \
  okular
```

### Audio

```
sudo pacman -S \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  wireplumber
```

### Applications

```
sudo pacman -S \
  mpv \
  libreoffice-fresh
```

## KDE User

`System Settings → System → Users → Your Account`

- Name: BOKSHI
- Avatar: [avatar.png](../kde-plasma/user/avatar.png)

## KDE Theme & Wallpaper

- Global Theme: **Breeze Dark**\
  `System Settings → Appearance & Style → Global Theme`
- Desktop Wallpaper: [plasma-desktop.png](../kde-plasma/backgrounds/plasma-desktop.png)\
  `System Settings → Appearance & Style → Wallpaper`
- Lock Screen Wallpaper: [plasma-lockscreen.png](../kde-plasma/backgrounds/plasma-lockscreen.png)\
  `System Settings → Security & Privacy → Screen Locking → Configure Appearance`

## KDE Default Bottom Panel

`Right-click Panel → Show Panel Configuration`

- Pager: Not present
- Task Manager: Running applications only
  - Pinned applications: None
- Peek at Desktop: Not present

 ## SDDM Theme

`System Settings → Colors & Themes → Login Screen (SDDM)`

- Theme: **Breeze**
  - Background: [sddm-login.png](../kde-plasma/backgrounds/sddm-login.png)

## Mouse

`System Settings → Input & Output → Mouse & Touchpad`

- Pointer speed: `0.20`
- Invert scroll direction (Natural scrolling): Enabled

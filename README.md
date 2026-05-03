Jemos Dotfiles 🌙
Mi primer rice creado desde cero, inspirado en The Glorious Dotfiles. En lugar de copiar configs, fui aprendiendo y construyendo mi propia versión paso a paso, entendiendo cada cosa que agregaba y por qué.
La filosofía detrás de este setup es simple: que se vea bien sin sacrificar rendimiento. Awesome WM consume muy poca RAM comparado con entornos de escritorio completos como GNOME o KDE, lo que se traduce en mayor fluidez del sistema y mejor duración de batería, algo especialmente importante en laptops. Picom está configurado con el backend GLX para aprovechar la GPU y mantener las animaciones suaves sin impacto notable en el consumo.
Setup

OS: Manjaro Linux
WM: Awesome WM
Terminal: Kitty
Shell: Zsh + Oh My Zsh
Editor: Micro
File Manager: Thunar
Compositor: Picom (transparencia + bordes redondeados)
Theme: Matcha-dark-sea (GTK) + KvArcDark (Qt)
Icons: Papirus-Dark
Font: JetBrains Mono

Features

Popups de volumen y brillo con teclas multimedia
Barra minimalista oscura translúcida
Transparencia en Kitty y Thunar
Screenshots con Flameshot (Super+Shift+S)
Bajo consumo de RAM y batería gracias a Awesome WM
Sin compositor pesado, Picom ligero con GLX

Dependencias

awesome, picom, kitty, thunar, feh, flameshot
pamixer, brightnessctl para los popups
kvantum, qt5ct para apps Qt
papirus-icon-theme, ttf-jetbrains-mono

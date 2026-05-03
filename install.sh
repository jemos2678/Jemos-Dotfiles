#!/bin/bash

echo "=== Jemos Dotfiles - Instalador ==="
echo "Instalando dependencias..."

sudo pacman -S --noconfirm awesome picom kitty thunar feh flameshot \
  pamixer brightnessctl kvantum kvantum-qt5 qt5ct \
  papirus-icon-theme ttf-jetbrains-mono rofi xorg-xrandr xorg-xev

echo "Copiando configuraciones..."

mkdir -p ~/.config/awesome
mkdir -p ~/.config/kitty
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/rofi

cp rc.lua ~/.config/awesome/
cp popups.lua ~/.config/awesome/
cp picom.conf ~/.config/
cp kitty.conf ~/.config/kitty/
cp settings.ini ~/.config/gtk-3.0/
cp config.rasi ~/.config/rofi/
cp .xprofile ~/

echo "Aplicando tema de iconos..."
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

echo "=== Instalacion completa! ==="
echo "Recuerda configurar Kvantum con KvArcDark y reiniciar sesion."

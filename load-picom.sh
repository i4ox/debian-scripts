#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"


# Установка зависимостей
$ld apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev -yy

# Сборка picom-ftlabs
git clone https://github.com/FT-Labs/picom.git
cd picom
meson setup --buildtype=release build
ninja -C build
$ld mv build/src/picom /usr/local/bin/picom
cd ..
rm -rf picom

[ -x "$(command -v wget)" ] || $ld apt install wget -yy

# Установка конфига для picom
mkdir ~/.config/picom
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/picom/picom.conf
mv picom.conf ~/.config/picom/picom.conf

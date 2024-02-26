#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Установка curl, cmake, pkg-config, wget если есть необходимость
[ -x "$(command -v curl)" ] || $ld apt install curl -yy
[ -x "$(command -v cmake)" ] || $ld apt install cmake -yy
[ -x "$(command -v pkg-config)" ] || $ld apt install pkg-config -yy
[ -x "$(command -v wget)" ] || $ld apt install wget -yy

# Установка cargo и rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# Установка зависимостей
$ld apt install libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# Сборка alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release --no-default-features --features=x11

# Установка alacritty
$ld apt install desktop-file-utils -yy
$ld cp target/release/alacritty /usr/local/bin
$ld cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
$ld desktop-file-install extra/linux/Alacritty.desktop
$ld update-desktop-database

# Удаляем архив с установленным alacritty
cd .. && $ld rm -rf alacritty

# Делаем alacritty терминалам по-умолчанию для i3
if [ -x "$(command -v i3)" ]; then
    sed -i "s/xterm/alacritty/g" $HOME/.config/i3/config
else
    printf "${red}i3 don't install ${nc}\n"
    exit 0
fi

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

# Установка конфига
mkdir ~/.config/alacritty
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/alacritty/alacritty.toml
mv alacritty.toml ~/.config/alacritty/alacritty.toml


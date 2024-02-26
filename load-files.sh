#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
scripts="$HOME/scripts"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

$ld apt install doublecmd-common -yy

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/user-dirs.dirs
mv user-dirs.dirs ~/.config/user-dirs.dirs

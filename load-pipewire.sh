#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
scripts="$HOME/scripts"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

$ld apt install pipewire pipewire-audio pipewire-alsa pipewire-jack wireplumber pipewire-pulse -yy

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/scripts/pipewire.sh

if [ -d "$scripts" ]; then
    printf ${yellow}"scripts directory for pipewire already exists ${nc}\n"
else
    mkdir ~/scripts
fi

mv pipewire.sh ~/scripts/pipewire.sh
$ld chmod +x ~/scripts/pipewire.sh

printf ${yellow}"PIPEWIRE ALREADY INSTALLED, PLEASE REBOOT THE PC ${nc}\n"
#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

$ld apt install pipewire pipewire-audio pipewire-alsa pipewire-jack wireplumber pipewire-pulse

printf ${yellow}"PIPEWIRE ALREADY INSTALLED, PLEASE REBOOT THE PC ${nc}\n"
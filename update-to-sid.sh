#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"


printf ${yellow}"Official deb mirrors or yandex mirrors(deb or ya): ${nc}\n"
read mirrors

if [ "$mirrors" ==  "deb" ]; then
    wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/services/pkg/sources-deb.list
    $ld mv sources-deb.list /etc/apt/sources.list
elif [ "$mirrors" == "ya" ]; then
    wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/services/pkg/sources-ya.list
    $ld mv sources-ya.list /etc/apt/sources.list
fi

$ld apt update -yy
$ld apt upgrade -yy
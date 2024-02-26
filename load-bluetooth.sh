#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
scripts="$HOME/scripts"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Установка инструментов для поддержки bluetooth
$ld apt install bluez -yy

# Проверка установлен ли git
[ -x "$(command -v git)" ] || $ld apt install git

# Установка bluetuith
git clone https://github.com/darkhz/bluetuith
cd bluetuith
go build
$ld mv bluetuith /usr/local/bin/
cd ..
rm -rf bluetuith

printf ${yellow}"BLUETOOTH TOOLS ALREADY INSTALLED, PLEASE REBOOT THE PC ${nc}\n"

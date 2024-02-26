#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
user="$(getent group 1000 | cut -d':' -f 1)"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Создаем подкаталог для нашей сессии
$ld mkdir -p /etc/systemd/system/getty@tty1.service.d/

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

# Установка конфига для автологина
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/admin/autologin.conf
sed -i "s/artlkv/${user}/g" autologin.conf
$ld mv autologin.conf /etc/systemd/system/getty@tty1.service.d/override.conf

# Завершение работы скрипта
printf ${yellow}"AUTOLOGIN ENABLE, PLEASE REBOOT THE PC TO CHECK ${nc}\n"

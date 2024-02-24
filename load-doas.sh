#!/bin/bash

# Переменные
red="\033[0;31m"
nc="\033[0m"
user="$(getent group 1000 | cut -d':' -f 1)"
runas=($whoami)

# Проверка на то является ли пользователь root
[ $runas != 'root' ] && printf "${red}command must be run as root...exiting ${nc}\n" && exit 1

# Установка open-doas
apt install doas -yy

# Проверка на то существует ли уже конфиг
[ -e /etc/doas.conf ] && printf "${red} /etc/doas.conf already exists, move to a backup location and run script again.${nc}\n" \
&& exit 1

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || apt install wget

# Установка конфига для open-doas
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/admin/doas.conf

# Замена стандартного пользователя в скрипте на текущего
sed -i "s/artlkv/${user}/g" doas.conf

mv doas.conf /etc/doas.conf



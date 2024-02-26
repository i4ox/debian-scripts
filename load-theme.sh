#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
themes="/usr/share/themes/"
icons="/usr/share/icons/"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

[ -x "$(command -v wget)" ] || $ld apt install wget

# Установка софта для кастомизации
$ld apt install lxappearance kvantum qt5ct

# Установка иконок
$ld sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main' > /etc/apt/sources.list.d/papirus-ppa.list"
$ld wget -qO /etc/apt/trusted.gpg.d/papirus-ppa.asc 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'
$ld apt update
$ld apt install papirus-icon-theme

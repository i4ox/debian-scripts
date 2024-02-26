#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Установка драйверов nvidia
$ld apt install linux-headers-amd64 -yy
$ld apt install nvidia-driver firmware-misc-nonfree -yy
$ld dpkg --add-architecture i386 && $ld apt update --yy
$ld apt install nvidia-driver-libs:i386 --yy

printf ${yellow}"NVIDIA DRIVERS ALREADY INSTALLED, PLEASE REBOOT THE PC ${nc}\n"

#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"


$ld apt install linux-headers-amd64
$ld apt install nvidia-driver firmware-misc-nonfree
$ld dpkg --add-architecture i386 && $ld apt update
$ld apt install nvidia-libs:i386

printf ${yellow}"NVIDIA DRIVERS ALREADY INSTALLED, PLEASE REBOOT THE PC ${nc}\n"
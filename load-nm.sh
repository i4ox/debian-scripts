#!/bin/bash

# Определяем используется open-doas или sudo
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# Установка NetworkManager
$ld apt install network-manager wpasupplicant -yy

# Заменяем конфиг по-умолчанию
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/services/NetworkManager.conf
$ld chmod 644 NetworkManager.conf
$ld mv NetworkManager.conf /etc/NetworkManager/NetworkManager.conf

# Отключаем networking
$ld systemctl stop networking
$ld systemctl disable networking
$ld systemctl stop wpa_supplicant
$ld systemctl disable wpa_supplicant

# Включаем Network-Manager
$ld systemctl enable NetworkManager
$ld systemctl restart NetworkManager

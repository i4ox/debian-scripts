#!/bin/bash

# Определяем используется open-doas или sudo
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"
[ -x "$(command -v sudo)" ] && ld="sudo"

# Установка NetworkManager
$ld apt install network-manager wpasupplicant

# Заменяем конфиг по-умолчанию
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/services/NetworkManager.conf
mv NetworkManager.conf /etc/NetworkManager/NetworkManager.conf

# Отключаем networking
systemctl stop networking
systemctl disable networking

# Включаем Network-Manager
systemctl enable wpa_supplicant
systemctl enable NetworkManager
systemctl restart wpa_supplicant
systemctl restart NetworkManager

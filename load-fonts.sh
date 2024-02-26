#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Установка wget и unzip, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget
[ -x "$(command -v unzip)" ] || $ld apt install unzip

# Скачиваем CascadiaCode с NF патчем
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip

# Распаковываем архив с CascadiaCode
unzip CascadiaCode.zip -d cc

# Установка шрифта CascadiaCode
$ld mkdir /usr/share/fonts/CascadiaCode
$ld cp cc/*.ttf /usr/share/fonts/CascadiaCode
$ld fc-cache --force

# Удаляем архив с CascadiaCode
rm -rf cc CascadiaCode.zip

# Установка Font Awesome
wget https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip
unzip fontawesome-free-6.5.1-desktop.zip -d fa
$ld mkdir /usr/share/fonts/fontawesome
$ld cp -r fa/* /usr/share/fonts/fontawesome
$ld fc-cache --force

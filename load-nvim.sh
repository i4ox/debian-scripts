#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
shell="$(echo $SHELL)"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

# Установка nvim
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
$ld mv nvim-linux64 /opt/nvim

# Добавляем nvim в переменные среды
if [ "$shell" = "/bin/bash" ]; then
    echo 'export PATH="$PATH:/opt/nvim/bin"' >> ~/.bash_profile
    source ~/.bash_profile
elif [ "$shell" = "/bin/zsh" ]; then
    echo 'export PATH="$PATH:/opt/nvim/bin"' >> ~/.zprofile
    source ~/.zprofile
fi

# Удаляем архив с установленным nvim
rm -rf nvim-linux64.tar.gz

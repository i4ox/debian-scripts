#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
confdir="$HOME/.config/i3"
shell="$(echo $SHELL)"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

$ld apt install xorg xclip xinit i3-wm

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/i3/config

if [ -d "$confdir" ]; then
    printf ${yellow}"config directory for i3 already exists ${nc}\n"
else
    mkdir -p $confdir
fi

mv config $confdir/config

wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/admin/xinitrc
mv xinitrc ~/.xinitrc

if [ "$shell" = "/bin/bash" ]; then
    echo 'if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then' >> ~/.bash_profile
    echo '  exec startx' >> ~/.bash_profile
    echo 'fi' >> ~/.bash_profile
    cat ~/.bash_profile
elif [ "$shell" = "/bin/zsh" ]; then
    echo 'if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then' >> ~/.zprofile
    echo '  exec startx' >> ~/.zprofile
    echo 'fi' >> ~/.zprofile
    cat ~/.zprofile
fi


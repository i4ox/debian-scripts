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

$ld apt install xorg xclip xinit i3-wm nitrogen flameshot dunst

# Установка wget, если есть необходимость
[ -x "$(command -v wget)" ] || $ld apt install wget

# Устанавливаем конфиг для i3-wm
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/i3/config
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/.config/dunst/dunstrc

# Проверяем существует ли каталог для конфигурации
if [ -d "$confdir" ]; then
    printf ${yellow}"config directory for i3 already exists ${nc}\n"
else
    mkdir -p $confdir
fi

if [ -d "$HOME/.config/dunst" ]; then
    printf ${yellow}"config directory for dunst already exists ${nc}\n"
else
    mkdir -p $HOME/.config/dunst
fi

# Помещаем конфиг в нужный каталог
mv config $confdir/config
mv dunstrc ~/.config/dunst/dunstrc

# Создаем xinit файл
wget https://codeberg.org/i4ox/dotfiles/raw/branch/main/admin/xinitrc
mv xinitrc ~/.xinitrc

# Команда для автозапуска
if [ "$shell" = "/bin/bash" ]; then
    echo 'if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then' >> ~/.bash_profile
    echo '  exec startx' >> ~/.bash_profile
    echo 'fi' >> ~/.bash_profile
    cat ~/.bash_profile
fi


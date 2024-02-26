#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Проверяем установлен ли cargo и rust или нет
if [ -x "$(command -v cargo)" ]; then
  source $HOME/.cargo/env
else
  [ -x "$(command -v curl)" ] || $ld apt install curl -yy
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
  source $HOME/.cargo/env
fi

# Клонируем репозиторий с eww
git clone https://github.com/elkowar/eww
cd eww

# Установка зависимостей
$ld apt install libqt5glib-2.0-0 libspice-client-glib-2.0-8 libspice-client-glib-2.0-dev libgdk-pixbuf-2.0-dev libgdk-pixbuf2.0-dev librust-atk-dev librust-atk-sys-dev libcairo-gobject2 libcairo-gobject-perl librust-cairo-rs-dev librust-cairo-sys-rs-dev librust-pangocairo-dev librust-pangocairo-sys-dev librust-gdk-pixbuf-dev librust-gdk-pixbuf-sys-dev librust-gdk-sys-dev stalonetray

# Сборка и установка eww
cargo build --release --no-default-features --features x11
$ld chmod +x target/release/eww
$ld cp target/release/eww /usr/local/bin

printf "${red}Please setup eww config manually!!${nc}\n"

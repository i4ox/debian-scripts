#!/bin/bash

# Переменные
red='\033[0;31m'
nc='\033[0m'
yellow='\033[1;33m'
srcdir="$HOME/.local/src"
shell="$(echo $SHELL | cut -d"/" -f 4)"

# Определяем используется open-doas или sudo
[ -x "$(command -v sudo)" ] && ld="sudo"
[ -x "$(command -v doas)" ] && [ -e /etc/doas.conf ] && ld="doas"

# Проверяем установлен ли apt-fast в системе
if [ -x "$(command -v apt-fast)" ]; then
    printf ${yellow}"apt-fast already installed ${nc}\n"
    printf ${yellow}"it can be configured in /etc/apt-fast.conf ${nc}\n"
    exit 0
fi

# Проверяем была ли уже попытка провести сборку apt-fast, если нет то копируем git репозиторий
if [ -d "$srcdir/apt-fast" ]; then
    printf ${yellow}"source directory for apt-fast already exists ${nc}\n"
else
    $ld apt install aria2 -yy
    git clone https://github.com/ilikenwf/apt-fast
    cd apt-fast
    $ld cp apt-fast /usr/local/sbin/
    $ld chmod +x /usr/local/sbin/apt-fast
    $ld cp apt-fast.conf /etc
fi

# Проверяем создана ли уже директория с исходниками
if [ -d "$srcdir" ]; then
    printf ${yellow}"source directory already exists ${nc}\n"
else
    mkdir -p $srcdir
    printf ${yellow}"source directory created in $srcdir ${nc}\n"
fi

# Устанавливаем авто-дополнение для правильной оболочки
if [ "$shell" = "bash" ]; then
    $ld apt install bash-completion -yy
    $ld cp completions/bash/apt-fast /etc/bash_completion.d/
    $ld chown root:root /etc/bash_completion.d/apt-fast
    ./etc/bash_completion
elif [ "$shell" = "zsh" ]; then
    $ld cp completions/zsh/_apt-fast /usr/share/zsh/functions/Completion/Debian/
    $ld chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
    source /usr/share/zsh/functions/Completion/Debian/_apt-fast
fi


# Перемещаем документацию на свое место
if [ -f "/usr/local/share/man/man8/apt-fast.8" ]; then
    printf ${yellow}"apt-fast.8 already in proper location ${nc}\n"
else
    $ld mkdir -p /usr/local/share/man/man8/
    printf ${yellow}"directory created for apt-fast ${nc}\n"
    printf ${yellow}"in /usr/local/share/man/man8 ${nc}\n"
    $ld cp ./man/apt-fast.8 /usr/local/share/man/man8
    $ld gzip -f9 /usr/local/share/man/man8/apt-fast.8
fi

if [ -f "/usr/local/share/man/man5/apt-fast.conf.5" ]; then
    printf ${yellow}"apt-fast.conf.5 already in proper location ${nc}\n"
else
    $ld mkdir -p /usr/local/share/man/man5/
    printf ${yellow}"directory created for apt-fast.conf ${nc}\n"
    printf ${yellow}"in /usr/local/share/man/man5 ${nc}\n"
    $ld cp ./man/apt-fast.conf.5 /usr/local/share/man/man5
    $ld gzip -f9 /usr/local/share/man/man5/apt-fast.conf.5
fi

# Конец установки
printf ${yellow}"YOU ARE NOW ABLE TO USE APT-FAST \n"
printf "...apt-fast can be configured in /etc/apt-fast.conf \n"
printf "Feel free to peruse the config file...\n"
printf "uncomment these lines to get started \n"
printf "_APTMGR=apt-get (change to apt-get to apt if you want...) \n"
printf "DOWNLOADBEFORE=true \n"
printf "_MAXNUM=5 ${nc}\n"
exit 0

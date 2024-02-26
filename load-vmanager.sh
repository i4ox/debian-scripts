#!/bin/bash

# Переменные
red="\033[0;31m"
nc="\033[0m"
user="$(getent group 1000 | cut -d':' -f 1)"
runas=($whoami)

# Проверка на то является ли пользователь root
[ $runas != 'root' ] && printf "${red}command must be run as root...exiting ${nc}\n" && exit 1

# Установка зависимостей
apt install qemu-kvm libvirt-clients libvirt-daemon libvirt-daemon-system bridge-utils virtinst virt-manager -yy

# Запуск сервиса для libvirt
systemctl enable libvirtd
systemctl start libvirtd

# Добавляем пользователя к группам, связанным с libvirt
usermod -aG libvirt $user
usermod -aG kvm $user
usermod -aG libvirt-qemu $user

#!/bin/bash
# Author : Gazeka74 <gazeka74@gmail.com>

WHEREAMI=$(pwd)

WHOAMI=$(whoami)

OPTIONS="Options:
    -h, --help      This help menu.
    -r, --restore   Restore the dotfiles to the correct location
    -b, --backup    Backup the dotfiles and git add/commit/push"

function backup {

    printf "\n   BACKUPING FILES FOR THE USER : $WHOAMI\n\n"

    echo "=> backuping i3"
    mkdir -p $WHEREAMI/i3
    cp ~/.config/i3/config $WHEREAMI/i3/config

    echo "=> backuping polybar"
    mkdir -p $WHEREAMI/polybar
    cp ~/.config/polybar/config $WHEREAMI/polybar/config
    cp ~/.config/polybar/master.conf $WHEREAMI/polybar/master.conf
    cp ~/.config/polybar/modules.conf $WHEREAMI/polybar/modules.conf

    echo "=> backuping zshrc"
    cp ~/.zshrc $WHEREAMI/.zshrc

    echo "=> backuping termite"
    mkdir -p $WHEREAMI/termite
    cp ~/.config/termite/config $WHEREAMI/termite/config

    echo "=> backuping i3lock-fancy"
    mkdir -p $WHEREAMI/locker/usrshare/
    cp -r /usr/share/i3lock-fancy $WHEREAMI/locker/usrshare/i3lock-fancy
    cp /usr/bin/i3lock-fancy $WHEREAMI/locker/i3lock-fancy

    echo "=> backuping the background"
    mkdir -p $WHEREAMI/background/
    cp /home/loris/Images/background/background.png $WHEREAMI/background/background.png

    printf "=> pushing to git \n"

    git add .
    git commit -m "AUTO COMMIT : $(date)"
    git push origin master
}

function restore {
    printf "\n   RESTORING FILES FOR THE USER : $WHOAMI\n\n"
}
while true; do
    if [ -z "$1" ]; then
        printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n" ; exit 1
    fi

    case "$1" in
        -h|--help)
            printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n" ; exit 1 ;;
        -b|--backup)
            backup; exit 0;;
        -r|--restore)
            restore; exit 0;;
    esac
done






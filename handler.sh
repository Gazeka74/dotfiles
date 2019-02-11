#!/bin/bash
# Author : Gazeka74 <gazeka74@gmail.com>

WHEREAMI=$(pwd)

WHOAMI=$(whoami)

OPTIONS="Options:
    -h, --help      This help menu.
    -r, --restore   Restore the dotfiles to the correct location
    -b, --backup    Backup the dotfiles and git add/commit/push"

function backup {

    printf "\n===> BACKUPING FILES FOR THE USER : $WHOAMI\n\n"

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
    cp /home/$WHOAMI/Images/background/background.png $WHEREAMI/background/background.png

    echo "=> backuping rofi"
    mkdir -p $WHEREAMI/rofi/themes
    cp -r /usr/share/rofi/themes $WHEREAMI/rofi/themes/
    cp ~/.config/rofi/config $WHEREAMI/rofi/config

    printf "=> pushing to git \n\n"

    git add .
    git commit -m "AUTO COMMIT : $(date)"
    git push origin master
}

function restore {
    printf "\n===> RESTORING FILES FOR THE USER : $WHOAMI\n\n"

    echo "=> restoring i3"
    mkdir -p ~/.config/i3
    cp $WHEREAMI/i3/config ~/.config/i3/config

    echo "=> restoring polybar"
    mkdir -p ~/.config/polybar/
    cp $WHEREAMI/polybar/config ~/.config/polybar/config
    cp $WHEREAMI/polybar/master.conf ~/.config/polybar/master.conf
    cp $WHEREAMI/polybar/modules.conf ~/.config/polybar/modules.conf

    echo "=> restoring zshrc"
    cp $WHEREAMI/.zshrc ~/.zshrc

    echo "=> restoring termite"
    mkdir -p ~/.config/termite/
    cp $WHEREAMI/termite/config ~/.config/termite/config

    echo "=> restoring i3lock-fancy (require root rights)"
    sudo mkdir -p /usr/share/i3lock-fancy
    sudo cp -r $WHEREAMI/locker/usrshare/i3lock-fancy /usr/share/i3lock-fancy
    sudo cp $WHEREAMI/locker/i3lock-fancy /usr/bin/i3lock-fancy 

    echo "=> restoring the background"
    mkdir -p /home/$WHOAMI/Images/background/
    cp $WHEREAMI/background/background.png /home/$WHOAMI/Images/background/background.png

    echo "=> restoring rofi"
    sudo mkdir -p /usr/share/rofi/themes
    sudo cp -r $WHEREAMI/rofi/themes /usr/share/rofi/themes
    cp  $WHEREAMI/rofi/config ~/.config/rofi/config

}

function print_usage {
    printf "Usage:\n     $(basename $0) [options]\n\n$OPTIONS\n\n"
}
while true; do
    if [ -z "$1" ]; then
        print_usage ; exit 1
    fi
    case "$1" in
        -h|--help)
            print_usage ; exit 1 ;;
        -b|--backup)
            backup; exit 0;;
        -r|--restore)
            restore; exit 0;;
    esac
done






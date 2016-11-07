#!/bin/bash

SCRIPTDIR=$(pwd)/confs

function install_file {
    if [ ! -e $2 ]; then
        echo "File $2 is missing. Error!" >&2
        exit 1
    fi

    if [ -e $1 ]; then
        echo "File $1 already exists. Skipping!"
    elif [ -h $1 ]; then
        echo "File $1 already exists and is symbolic link. Skipping!"
    else
        echo "Installing config $2"
        ln -s $2 $1
    fi
}

install_file ~/.bashrc $SCRIPTDIR/bashrc
install_file ~/.config/kak/kakrc $SCRIPTDIR/kakrc
install_file ~/.tmux.conf $SCRIPTDIR/tmux.conf

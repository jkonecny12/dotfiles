#!/bin/bash

SCRIPTDIR=$(pwd)/confs

function install_file {
    if [ -e $1 ]; then
        echo "File $1 already exists. Skipping!"
    else
        echo "Installing config $2"
        ln -s $2 $1
    fi
}

install_file ~/.bashrc $SCRIPTDIR/bashrc
install_file ~/.config/kak/kakrc $SCRIPTDIR/kakrc


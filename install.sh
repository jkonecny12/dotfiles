#!/bin/bash

SCRIPTDIR=$(pwd)/confs

BINDIR=$(pwd)/bin

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
        echo "Creating symbolic link to $2"
        ln -s $2 $1
    fi
}

install_file ~/.bashrc $SCRIPTDIR/bashrc
install_file ~/.config/kak/kakrc $SCRIPTDIR/kakrc
install_file ~/.tmux.conf $SCRIPTDIR/tmux.conf
install_file ~/.gitconfig $SCRIPTDIR/gitconfig
install_file ~/.gitignore $SCRIPTDIR/gitignore
install_file ~/.spacemacs $SCRIPTDIR/spacemacs

# install user bin files
for i in $(ls $BINDIR); do
    install_file ~/bin/$i $BINDIR/$i
done


#!/bin/bash

CONFDIR=$(pwd)/confs

BINDIR=$(pwd)/bin

function install_file {
    if [ ! -e $2 ]; then
        echo "File $2 is missing. Error!" >&2
        exit 1
    fi

    if [ -h $1 ]; then
        echo "File $1 is a symbolic link. Skipping!"
    elif [ -e $1 ]; then
        echo "File $1 already exists and it is NOT a symbolic link. Skipping!"
    else
	CONFDIR=$(dirname $1)
	if [ ! -d $CONFDIR ]; then
	    echo "Directory is missing -- creating!"
	    mkdir -p $CONFDIR
	fi

        echo "Creating symbolic link to $2"
        ln -s $2 $1
    fi
}

function install_dir {
    if [ ! -d $2 ]; then
        echo "Directory $2 is missing. Error!" >&2
        exit 1
    fi

    if [ -h $1 ]; then
        echo "Directory $1 is a symbolic link. Skipping!"
    elif [ -d $1 ]; then
        echo "Directory $1 already exists and it is NOT a symbolic link. Skipping!"
    else
        echo "Creating symbolic link to $2"
        ln -s $2 $1
    fi
}

install_file ~/.bashrc $CONFDIR/bashrc
install_file ~/.config/kak/kakrc $CONFDIR/kakrc
install_file ~/.tmux.conf $CONFDIR/tmux.conf
install_file ~/.gitconfig $CONFDIR/gitconfig
install_file ~/.gitignore $CONFDIR/gitignore
install_file ~/.spacemacs $CONFDIR/spacemacs

install_dir ~/.config/fish $CONFDIR/fish

# install user bin files
for i in $(ls $BINDIR); do
    install_file ~/bin/$i $BINDIR/$i
done


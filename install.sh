#!/bin/bash

CONFDIR=$(pwd)/confs
BINDIR=$(pwd)/bin
REMOVE=true

if [ "$1" == "noremove" ]; then
    REMOVE=false
elif [ "$#" -gt 1 ]; then
    echo "The only valid parameter is --noremove!" >&2
    echo "--noremove  - Backup and remove existing files which are not symlinks." >&2
    exit 2
fi


function install_file {
    if [ ! -e $2 ]; then
        echo "File $2 is missing. Error!" >&2
        exit 1
    fi

    if [ -h $1 ]; then
        echo "File $1 is a symbolic link. Skipping!"
    elif [ -e $1 ]; then
	if $REMOVE; then
	    backup_and_remove $1
	    create_symlink $1 $2
	else
            echo "File $1 already exists and it is NOT a symbolic link. Skipping!"
	fi
    else
	create_symlink $1 $2
    fi
}

function create_symlink {
    original=$1
    new=$2
    ORIG_CONF_DIR=$(dirname $original)

    if [ ! -d $ORIG_CONF_DIR ]; then
        echo "Directory is missing -- creating!"
        mkdir -p $ORIG_CONF_DIR
    fi

    echo "Creating symbolic link to $original"
    ln -s $new $original
}

function backup_and_remove {
    if [ -e $1 ]; then
	mv $1 "$1.back"
	echo "Backup $1.back created" >&2
    else
	echo "Nothing to backup and remove -- this is most probably bug in the code!" >&2
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
	if $REMOVE; then
	    backup_and_remove $1
	    create_symlink $1 $2
	else
	    echo "Directory $1 already exists and it is NOT a symbolic link. Skipping!"
	fi
    else
	create_symlink $1 $2
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


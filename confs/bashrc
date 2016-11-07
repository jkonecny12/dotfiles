# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
IGREEN='\e[0;92m'
BGREEN='\e[1;92m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
magenta='\e[0;35m'
MAGENTA='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color

# Taken from http://www.opinionatedprogrammer.com/2011/01/colorful-bash-prompt-reflecting-git-status/
function _git_prompt() {
local git_status="`git status -unormal 2>&1`"
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
        local ansi=$GREEN
    elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
        local ansi=$RED
    else
        local ansi=$YELLOW
    fi
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
        branch=${BASH_REMATCH[1]}
        #test "$branch" != master || branch=' '
    else
        # Detached HEAD. (branch=HEAD is a faster alternative.)
        branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
            echo HEAD`)"
    fi
    echo -n ''"\[$BGREEN\][\[$NC\]"'\['"$ansi"'\]'"$branch"'\['"$NC"'\]'"\[$BGREEN\]]\[$NC\]"''
fi
}

function report_status() {
RET_CODE=$?
if [[ $RET_CODE -ne 0 ]] ; then
    echo -ne "\[$BGREEN\][\[$NC\]\[$RED\]$RET_CODE\[$NC\]\[$BGREEN\]]\[$NC\]"
fi
}

export _PS1="\[$NC\]\[$BGREEN\][\[$NC\]\[$green\]\u\[$NC\] \[$BLUE\]\W\[$NC\]\[$BGREEN\]] \[$IGREEN\]\$\[$NC\]"
export PS2="\[$NC\]\[$IGREEN\]>\[$NC\] "
export PROMPT_COMMAND='_status=$(report_status);export PS1="$(_git_prompt)${_status}${_PS1} ";unset _status;'

# User specific aliases and functions

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# autostart gnome-keyring for ssh keys
#gnome-keyring-daemon -s

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u:\w\$ '
#fi

#Aliases
alias sl="ls"
alias la="ll -a"
alias ll="ls -lh"

alias gitci="git commit"
alias gitd="git diff --color"
alias gits="git status"

alias cdp="cd ~/RH/projects"
alias cds="cd ~/RH/scripts/vm_scripts/"

# enviroment variables
export EDITOR='vim'
export LC_TIME='en_GB.UTF-8'

#!/bin/bash
# Script that makes some essential directories and modifys bash to my liking
#rm -rf ~/.bashrc ~/.profile
#cp .bashrc ~/.bashrc
#cp .profile ~/.profile

confirm () {
    read -r -p "${1:-Proceed? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false=exit
            ;;
    esac
}

############################################
# Begin
############################################
printf "handyman \n" && sleep 1
printf "making some home directories if they don't already exist \n" && sleep 0.5
mkdir -v ~/bin
mkdir -v ~/.config
mkdir -v ~/.config/conky
mkdir -v ~/etc
mkdir -v ~/Downloads
sleep 2

############################################
# .profile
############################################
printf "Modify .profile \n\n" && sleep 1

confirm && if grep -Fxq "foofoo" ~/.profile
then
    printf "foofoo \n\n"
else
    cat > $HOME/.profile << __PROFILE__
# ~/.profile: executed by the command interpreter for login shells.
# for umask for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "\$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "\$HOME/.bashrc" ]; then
    . "\$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "\$HOME/bin" ] ; then
    PATH="\$HOME/bin:\$PATH"
fi
__PROFILE__
############################################
fi

printf ".profile written \n\n" 
sleep 2

############################################
# .bashrc
############################################
printf "Modify .bashrc \n\n" && sleep 1

confirm && if grep -Fxq "foofoo" ~/.bashrc
then
    printf "foofoo \n\n"
else
    cat > $HOME/.bashrc << __BASHRC__
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case \$- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "\$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "\${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=\$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "\$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Colored prompt
force_color_prompt=yes

if [ -n "\$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "\$color_prompt" = yes ]; then
    PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;33m\]\u@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\${debian_chroot:+(\$debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "\$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\${debian_chroot:+(\$debian_chroot)}\u@\h: \w\a\]\$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "\$(dircolors -b ~/.dircolors)" || eval "\$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias ll='ls -hal'
alias lol='ls -hal'
alias la='ls -A'
alias l='ls -CF'

# equal opportunity manual
alias woman='man'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



__BASHRC__

############################################
fi

############################################
# .config, Downloads, bin folders populate
############################################
cp .config/* ~/.config -R
cp bin/* ~/bin/
cp Downloads/* ~/Downloads -R
############################################
printf ".bashrc written \n\n" 
sleep 1
printf "\nOMFG I HOPE NOTHING BROKE\n"

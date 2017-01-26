#!/bin/bash
#
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
mkdir -v ~/.config/conky
mkdir -v ~/etc
mkdir -v ~/Downloads
sleep 2

############################################
# .profile
############################################
printf "Modify .profile \n\n" && sleep 1

confirm && then cat > $HOME/.profile << __PROFILE__
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

############################################
# .bashrc
############################################
printf "Modify .bashrc \n\n" && sleep 1

confirm && then cat > $HOME/.profile << __PROFILE__
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


############################################
# script shuffle time
# aka "wow I cant believe you made it this far"
############################################
printf "\nOMFG \n"

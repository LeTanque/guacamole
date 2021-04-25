# Normally handled by omz
autoload -Uz compinit
compinit

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH="/usr/share/man:$MANPATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/tank/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="tankx"
DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=60
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
	git
	osx
	dotenv
	themes
)

source $ZSH/oh-my-zsh.sh
export MANPATH="/usr/share/man:$MANPATH"
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# Aliases
alias ls='lsd'
alias ll='ls -hal'
alias lol='ls -ha'
alias lsl='ls -harlt'
alias woman='man'
alias subl='sublime'
alias matrix='cat /dev/urandom | hexdump -C | grep -e "9f c3" -e "c3 32" -e "32 0b" -e "0b 15" -e "15 15" '
alias getDeviceAddresses='ifconfig | egrep "lo[0-9]|en[0-9]|inet|tun[0-9]"'
alias gitUpdateCheckoutDevelop='git checkout develop && git pull origin develop && git hf update'
alias gitAddCommit='git add . && git commit'
alias gitPrune='git remote update origin --prune'
alias gitGraphCommits='git log --graph --pretty=oneline --all'
alias gitPullOriginDevelop='git pull origin develop'
alias startCodeServer='brew services start code-server'
alias restartCodeServer='brew services restart code-server'

gitStartFeature () {
	echo 'Checkout develop, pull origin, hf update, then start the feature.'
	echo 'Requires one parameter.'
	git checkout develop
	git pull origin develop
	git hf update
	git hf feature start '$1'
}

mkcd () {
    mkdir "$1"
    cd "$1"
}

cdc () {
	cd "$1"
	lsl
}


# Make a directory and change into it
mkcd () {
    mkdir "$1"
    cd "$1"
}

# Cd and lsl
cdc () {
	cd "$1"
	lsl
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/gettext/bin:$PATH"
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

neofetch

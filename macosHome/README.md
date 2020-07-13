# Getting started on MacOS

- add ssh key
- install yarn
- install oh-my-zsh
- install homebrew
- install fonts
- install neofetch
- install lsd
- apply iterm profile
- install node

## Adding ssh key

After the keys are added to the .ssh folder, make sure to chmod them to 700. Then add them to the agent

```bash
ssh-add -K .ssh/id_rsa
```

Now you can push and pull.

## Install Yarn

```zsh
brew install yarn
```

## Install oh-my-zsh

```bash
sh -c “$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Homebrew

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## Hack nerd Fonts

These are the fonts used in the zsh/iterm theme

```zsh
brew tap sambadevi/powerlevel9k
brew install powerlevel9k
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
```

## Hack font

Not used in the theme

https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack

macOS
- Download the latest version of [Hack](https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip).
- Extract the files from the archive (.zip) and click to open them.
- Follow the instructions from your operating system.
- Enjoy!

## Neofetch

```zsh
brew install neofetch
```

## Terminal tools

```zsh
brew install lsd
brew install arp-scan
brew install figlet
brew cask install xquartz
brew install toilet
```

## Node

Npm comes with node, in case you forgot.

[nodejs.org](https://nodejs.org/en/)

```bash
	•	Node.js v12.16.3 to /usr/local/bin/node
	•	npm v6.14.4 to /usr/local/bin/npm
```

## TODO

- Make this all into an autoscript

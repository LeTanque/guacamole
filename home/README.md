# New system procedure
Eventually turn this into a script.

## Basics
```bash
sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo apt install git figlet toilet build-essential curl file -y

mkdir ~/git
```

## Nerd fonts, guaca, and other terminal niceities
Lsd is used in the RUNME bash, so if this isn't installed for some reason, the bashrc needs to be updated.

```bash
git clone https://github.com/ryanoasis/nerd-fonts.git
git clone https://github.com/letanque/guacamole

cd ~/git/nerd-fonts
./install.sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install lsd

cd ~/git/guacamole/home
./RUNME.sh
```

## Homebrew
```bash
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

brew install hello
```

## Bitwarden
If there are problems using snaps, revert to the other install methods available at bitwarden.com

```bash
sudo apt install snapd
sudo snap install core
```

You can run the hello world program at this point to make sure it works correctly.
```bash
sudo snap install hello-world
```

```bash
sudo snap install bitwarden
```


## Github SSH
First, grab the keys from a secure channel, place in .ssh. Make sure the permissions are correct.

```bash
chmod 400 ~/.ssh/id_rsa*
ssh-add
ssh -T git@github.com
```

## Sexy bash prompt (git)
```bash
(cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install) && source ~/.bashrc
```


#### Notes
- Consider zsh as default shell? 
- Fix RUNME so that it doesn't require constant interaction or sleep
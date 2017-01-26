#/bin/bash
# GuacaMole handyman
 
GUACA='"$\HOME/bin:$\PATH"'

confirm () {
    read -r -p "${1:-Would you like to proceed? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
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
sleep 3



############################################
# script shuffle time
# aka "wow I cant believe you made it this far"
############################################
printf "\nOMFG \n"
printf "moving scripts to ~/bin and symlinking back here \n" && sleep 1
mv * ~/bin
mv ~/bin/RUNME.sh ~/git/guacamole-0.1/home/bin/RUNME.sh
mv ~/bin/README.md ~/git/guacamole-0.1/home/bin/README.md
#mv ~/git/guacamole-0.1/home/bin/!'RUNME.sh|README.md' ~/bin
printf ". \n" && sleep 1
cd ~/bin
printf "." && sleep 0.5 && printf ". \n" && sleep 0.5
ln -s ~/bin/* ~/git/guacamole-0.1/home/bin

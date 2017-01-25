#   __     _      
   / /_   (_)____ 
  / __ \ / // __ \
 / /_/ // // / / /
/_.___//_//_/ /_/ 
                
Files in this folder are designed to be housed in the user's private bin folder, chmod 700. With a 
modified .profile or .bashrc, a folder named 'bin' in the user's home directory will be added to the
user's $PATH and all executables within it easily executed from the command line. 

The files in this folder originated from a git folder with symlinks to the active scripts in ~/bin. 
With a 'hacked' pre-commit script, git quickly, and almost totally invisibly to the user, accesses 
the contents of the symlinks, transcribes to actual files, pushes to github, then cleans up the 
mess. This way github has actual files and local copies remain symlinks of actual ~/bin scripts. 
The point being that in the process of using github for 'version control', no unnecessary versions 
are created. 

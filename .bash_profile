# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

umask 022

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [ -f $HOME/.mybashrc ]; then
	. $HOME/.mybashrc
fi

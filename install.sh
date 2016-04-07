#!/bin/sh
SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname ${SCRIPT})

/usr/bin/cp -fr ${SCRIPTPATH}/.bashrc* $HOME
/usr/bin/cp -fr ${SCRIPTPATH}/.mybashrc $HOME
/usr/bin/cp -fr ${SCRIPTPATH}/.vimrc $HOME
/usr/bin/cp -fr ${SCRIPTPATH}/.inputrc $HOME

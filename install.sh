#!/bin/sh
SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname ${SCRIPT})

install_to="${1:-$HOME}"
cp -fr ${SCRIPTPATH}/.bashrc* ${install_to}
cp -fr ${SCRIPTPATH}/.mybashrc ${install_to}
cp -fr ${SCRIPTPATH}/.vimrc ${install_to}
cp -fr ${SCRIPTPATH}/.inputrc ${install_to}

#source ${HOME}/.bashrc

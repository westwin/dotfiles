#!/bin/sh
SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname ${SCRIPT})

cp -fr ${SCRIPTPATH}/.bashrc* $HOME
cp -fr ${SCRIPTPATH}/.mybashrc $HOME
cp -fr ${SCRIPTPATH}/.vimrc $HOME
cp -fr ${SCRIPTPATH}/.inputrc $HOME

source ${HOME}/.bashrc

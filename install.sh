#!/bin/sh
SCRIPT=$(readlink -f $0)
SCRIPTPATH=$(dirname ${SCRIPT})

install_to="${1:-$HOME}"
cp -fr ${SCRIPTPATH}/.bashrc* ${install_to}
cp -fr ${SCRIPTPATH}/.mybashrc ${install_to}
cp -fr ${SCRIPTPATH}/.vimrc ${install_to}
cp -fr ${SCRIPTPATH}/.inputrc ${install_to}
cp -fr ${SCRIPTPATH}/.tmux* ${install_to}

#source ${HOME}/.bashrc

# install vscode setting
vscode_user_dir=${install_to}/.config/Code/User
if [[ -d ${vscode_user_dir} ]]; then
    if [[ -f ${vscode_user_dir}/settings.json ]]; then
        # backup
        mv ${vscode_user_dir}/settings.json ${vscode_user_dir}/settings.json-before-dotfiles-install.backup

        ln -sf ${SCRIPTPATH}/vscode/User/settings.json ${vscode_user_dir}/settings.json
    fi

    if [[ -f ${vscode_user_dir}/keybindings.json ]]; then
        # backup
        mv ${vscode_user_dir}/keybindings.json ${vscode_user_dir}/keybindings.json-before-dotfiles-install.backup

        ln -sf ${SCRIPTPATH}/vscode/User/keybindings.json ${vscode_user_dir}/keybindings.json
    fi
fi


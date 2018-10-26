#filename globbing,for example ls -d ^Downloads to list all directories except Downloads
setopt extendedglob
export IBUS_ENABLE_SYNC_MODE=1

alias vim="vimx"
alias vi="vimx"

alias cp="cp -fr"
alias rm="rm -rf"
alias grep='grep --color=auto'
alias wget='wget --no-check-certificate'

#ss proxy
#export https_proxy="socks5://127.0.0.1:1080"
#export http_proxy="socks5://127.0.0.1:1080"

#find . -name "" | xargs grep -i "" -n 
# usage fx "*.java" "CollectionsUtil"
function fx() {
	find . -name "$1" 2>/dev/null | xargs grep -n -i "$2"  2>/dev/null
}
#ssh with root
function r(){
    local host="$1"
    shift
    ssh root@"${host}" "$@"
}

#mkdir and cd to
function mkc () { mkdir -p "$@" && eval cd "\"$@\""; }

# find helper
function f() {
  find . -name "*$1*" 2>/dev/null 
}

# find then ls -l
function fl () {
  find . -name "*$1*" 2>/dev/null -exec ls -l {} \;
}

#upload ssh public key
#USAGE: k root@192.168.22.235
alias k="ssh-copy-id -i $HOME/.ssh/id_rsa.pub "
#upload key then ssh
function ks(){
    local host="$1"
    local ip=$(echo ${host}|cut -d@ -f2 2>/dev/null)
    if [[ -n "${ip}" ]]; then
      grep ${ip} $HOME/.ssh/known_hosts >/dev/null
      if [[ $? -ne 0 ]]; then
        echo "uploading public key"
        ssh-copy-id -i $HOME/.ssh/id_rsa.pub "${host}"
      fi
    fi
    ssh -t "${host}" "bash -i -o vi"
}

#open default browser from command line.
alias o='open_command'

d=$HOME/Downloads

export PATH=$PATH:/usr/local/bin

#zsh-autosuggestions
bindkey '^ ' autosuggest-accept


#copy ssh public cert to clipboard
function cert() {
    local host=$1
    ssh root@${host} 'cat ~/.ssh/id_rsa.pub'|copyfile
}

alias s="rsync -avzh -e ssh --progress"

#intellij
export PATH=$PATH:$HOME/3rd/idea-IC-182.4505.22/bin


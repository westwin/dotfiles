tae=$HOME/work/ROOT/tae/
#wk=$HOME/work/ROOT/gopath/src/nationsky.com/gcs
uc=$HOME/work/ROOT/tae/user-center
u=$HOME/work/ROOT/tae/user-center-console
hu=$HOME/work/ROOT/tae/user-center-console-hr
o=$HOME/work/ROOT/tae/opendj
p=$HOME/work/ROOT/tae/paas
dex=$HOME/work/ROOT/gopath/src/github.com/dexidp/dex
npns=$HOME/work/ROOT/tae/paas/NPNS
paas=$HOME/work/ROOT/tae/paas
sag=$HOME/work/ROOT/tae/sag

docs=$HOME/work/ROOT/docs

export BUILD_NUMBER="fengxi-dev-build"

labs=(wechat-poc2 emm sag directory jira wiki bitbucket demo dns build sagbuild registry xfgw xfd5 xfd6 xfd7 xfd8 psr nfs1 xfvpn-s1 xfvpn-s2 xfvpn-c1 vpn-s1 vpn-c1 vpnbuild xf-dev-m1 xf-dev-n1)
####################lab env################################
function lab_alias(){
    local SVC_USER=nqsky
    local SVC_HOME=/home/${SVC_USER}

    #all labs
    LABS=""

    for lab in "${labs[@]}"; do
        #echo $lab
        #name=$(echo $lab | cut -d ':' -f1)
        #ip=$(echo $lab | cut -d ':' -f2)
        name=$(echo $lab | tr -d '-')
        ip=${lab}
        LABS="${LABS},${ip}"
        #echo $name
        #echo $ip
        lower=$(echo $name | tr '[:upper:]' '[:lower:]')
        upper=$(echo $name | tr '[:lower:]' '[:upper:]')

        env_cmd="export $upper=root@$ip:/root/" 
        alias_svc_ssh="alias n$lower='ssh -t $SVC_USER@$ip'"
        alias_root_ssh="alias r$lower='ssh -t root@$ip'"
        eval "${env_cmd}"
        eval "${alias_svc_ssh}"
        eval "${alias_root_ssh}"
    done

    export LABS=$(echo ${LABS} | cut -d , -f2-)
}

#setup lab alias.
lab_alias

####################################################
export UC_HOME="${HOME}/work/ROOT/tae/user-center"
#UC build alias
#do not build opendj
alias b="${UC_HOME}/topbuild/build.sh && ${UC_HOME}/topbuild/uc/package.sh && ${UC_HOME}/topbuild/docker/build.sh"

#rsync uc codes
alias sgu="rsync -havz -e ssh --progress --exclude .git --exclude .pyc $UC_HOME"

#command line create pull request
#1. add a remote of "MAIN" to public repo
#git remote add -t master MAIN ssh://git@192.168.22.67:7999/ptfm/user-center.git
function pr(){
    local title="$1"
    local desc="$2"
    if [[ -z "${desc}" ]]; then
        desc=${title}
    fi
    if [[ -z "${title}" ]]; then
        stash pull-request xf_dev MAIN/master -o
    else
        stash pull-request xf_dev MAIN/master -T "${title}" -d "${desc}" -o
    fi
}

function query(){
    local q="${1:-usercenter}"
    #curl -s "https://172.16.50.160:4443/v1/search?q=${q}"| pp_json | more
    curl --insecure https://${PREG}/v2/tae/${q}/tags/list
}

#fabric alias
if [[ -f $HOME/.vm-pwd ]]; then
    source $HOME/.vm-pwd
fi
alias fabb="fab --show=debug --user=root --password=${VM_PASSWORD} --parallel --pool-size=8 -H "

#reg
export QA1_REG=172.30.150.85
export DEV1_REG=172.30.221.56
export XF1_REG=172.30.206.107

#push reg,admin/admin123
export REG=registry.nscloud.local:5006
#pull reg,admin/admin123
export PREG=registry.nscloud.local:5005


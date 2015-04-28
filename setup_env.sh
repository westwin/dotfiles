#!/bin/bash
################################################################
# this script is used to setup python environment
#
##########################CHANGE ME#############################
#pkg install retries
declare -ir INSTALL_RETIRES=3
#wget download retries 
declare -ir WGET_RETRIES=3
#default JAVA_HOME
declare -r DEFAULT_JAVA_HOME="/usr/local/java/default"
#pip install timeout in sec
#declear -ir PIP_INSTALL_TIMEOUT=60
#oracle sdk rpm packages
declare -r ORACLE_SDK_BASIC_NAME="oracle-instantclient12.1-basic"
declare -r ORACLE_SDK_DEVEL_NAME="oracle-instantclient12.1-devel"
declare -r ORACLE_SDK_BASIC="$(dirname $0)/../tools/python/oracle/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm"
declare -r ORACLE_SDK_DEVEL="$(dirname $0)/../tools/python/oracle/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm"
declare -r ORACLE_INSTALL_SCRIPT="$(dirname $0)/install-cx_Oracle.sh"
#for CUR sso admin tools
declare -r USER_RUNNING_CUR="wibapp"
declare -r SSO_ADMIN_HOME="/var/wib/ssoadm"
declare -r SSO_ADMIN_BINARY="$(dirname $0)/../tools/openam/openam-distribution-ssoadmintools-12.0.0.zip"
################################################################

#print error msg in red.
function err(){
    echo -e "\e[31m$@\e[0m"
}
function usage(){
    echo "USAGE: sudo $(basename $0) -[sp]"
    echo -e "\t-s to set up sso admin tools on CUR"
    echo -e "\t-p to set up python environment"
    exit 1
}

function sep(){
    echo "------------------------------------------------------------"
}

#check if cur on this host is alive
function is_cur_alive(){
  live=$(curl http://$(hostname):8080/sso/isAlive.jsp 2>/dev/null | grep -i "Server is ALIVE")
  if [[ ! -z "${live}" ]]; then
    echo "CUR is ALIVE"
    return 0
  else
    echo "CUR is DEAD"
    return 1
  fi
}

#return 0:installed, 1:uninstalled
function is_yum_pkg_installed() {
    local pkg="$1"
    yum list installed ${pkg} &>/dev/null
    if [[ $? -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

#return 0:installed, 1:uninstalled
function is_rpm_pkg_installed() {
    local pkg="$1"
    rpm -q "${pkg}" &>/dev/null
    if [[ $? -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

#return 0:installed, 1:uninstalled
function is_bin_installed() {
    local bin="$1"    
    command -v ${bin} &>/dev/null
    if [[ $? -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

function install_yum_pkg_if_no(){
    sep
    local pkg="$1"
    echo "checking if $pkg is installed or not..."
    is_yum_pkg_installed "${pkg}"
    local installed=$?
    if [[ ${installed} -eq 0 ]]; then
        echo "${pkg} was already installed."
    else
        local retry=1
        echo "${pkg} was not installed,try to install with yum ${retry}/${INSTALL_RETIRES} ..."
        while [[ $retry -le $INSTALL_RETIRES ]]; do 
            sudo yum install -y "${pkg}"
            if [[ $? -eq 0 ]]; then
                echo "${pkg} is installed."
                return
            else
                let retry+=1
                if [[ $retry -gt ${INSTALL_RETIRES} ]]; then
                    err "${pkg} can not be installed. Please install manually ..."
                else 
                    echo "${pkg} can not be installed. Try again with yum ${retry}/${INSTALL_RETIRES} ..."
                fi
            fi
        done
    fi
    sep
}

#check if a python module is installed,
#return 0:installed, 1:uninstalled
function is_py_mod_installed() {
    local module="$1"
    pip show "${module}"
    local installed=$?
    if [[ ${installed} -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

function install_py_mod_if_no() {
    sep
    local module="$1"
    echo "checking if $module is installed or not..."
    is_py_mod_installed "${module}"
    local installed=$?
    if [[  ${installed} -eq 0 ]]; then
        echo "${module} was already installed."
    else
        local retry=1
        echo "${module} is not installed,try to install with pip ${retry}/${INSTALL_RETIRES} ..."
        while [[ ${retry} -le ${INSTALL_RETIRES} ]]; do
            sudo  pip install "${module}"
            if [[ $? -eq 0 ]]; then
                echo "${module} is installed."
                return
            else
                let retry+=1
                if [[ $retry -gt ${INSTALL_RETIRES} ]]; then
                    echo "${module} can not be installed. Please install manually."
                else
                    err "${module} can not be installed. Try with pip again ${retry}/${INSTALL_RETIRES} ..."
                fi
            fi
        done
    fi
    sep
}

#install cx_Oracle 
function install_cx_Oracle_if_no() {
    sep
    local module="cx-Oracle"
    echo "checking if $module is installed or not..."
    is_py_mod_installed "${module}"
    local installed=$?
    if [[  ${installed} -eq 0 ]]; then
        echo "${module} was already installed."
    else
        local retry=1
        echo "${module} is not installed,try to install with pip ${retry}/${INSTALL_RETIRES} ..."
        while [[ ${retry} -le ${INSTALL_RETIRES} ]]; do
            sudo bash ${ORACLE_INSTALL_SCRIPT}
            if [[ $? -eq 0 ]]; then
                echo "${module} is installed."
                return
            else
                let retry+=1
                if [[ $retry -gt ${INSTALL_RETIRES} ]]; then
                    echo "${module} can not be installed. Please install manually."
                else
                    err "${module} can not be installed. Try with pip again ${retry}/${INSTALL_RETIRES} ..."
                fi
            fi
        done
    fi
    sep
}

function install_py_pip_if_no(){
    sep
    is_yum_pkg_installed "python-pip"
    local yum_pkg_installed=$?
    is_bin_installed "pip"
    local pip_installed=$?

    if [[ ${yum_pkg_installed} -eq 0 || ${pip_installed} -eq 0 ]]; then
        echo "pip was already installed."
    else
        local retry=1
        echo "pip was not installed,try to install with yum/wget ${retry}/${INSTALL_RETIRES} ..."
        while [[ $retry -le $INSTALL_RETIRES ]]; do 
            sudo yum install -y python-pip
            local installed=$?
            if [[ ${installed} -ne 0 ]]; then
                echo "trying to download get-pip.py then install"
                wget --tries=${WGET_RETRIES} --no-check-certificate "https://bootstrap.pypa.io/get-pip.py" -O get-pip.py
                sudo python get-pip.py
                installed=$?
            fi

            if [[ ${installed} -eq 0 ]]; then
                echo "pip is installed."
                return
            else
                let retry+=1
                if [[ $retry -gt ${INSTALL_RETIRES} ]]; then
                    err "pip can not be installed. Please install manually ..."
                else 
                    echo "pip can not be installed. Try again with yum/wget ${retry}/${INSTALL_RETIRES} ..."
                fi
            fi
        done
    fi
    sep
}

function install_rpm_pkg_if_no() {
  local pkg_name="$1"
  local pkg_binary="$2"
  echo "checking if ${pkg_name} is installed or not..."
  is_rpm_pkg_installed "${pkg_name}"
  local pkg_installed=$?
  if [[ ${pkg_installed} -eq 0 ]]; then
    echo "${pkg_name} was already installed"
  else
    echo "${pkg_name} is not installed,trying to install..."
    sudo rpm -ivh "${pkg_binary}"
    if [[ $? -ne 0 ]]; then
      err "failed to install ${pkg_binary}, please fix manually"
    else
      echo "successfully installed ${pkg_binary}"
    fi
  fi
}
#install oracle sdk if not
function install_oracle_sdk_if_no() {
    sep
    install_rpm_pkg_if_no "${ORACLE_SDK_BASIC_NAME}" "${ORACLE_SDK_BASIC}"
    sep

    sep
    install_rpm_pkg_if_no "${ORACLE_SDK_DEVEL_NAME}" "${ORACLE_SDK_DEVEL}"
    sep
}

#install python oracle module if not
function install_py_oracle_mod_if_no(){
    install_oracle_sdk_if_no
    sep
    install_cx_Oracle_if_no
    sep
}

#export JAVA_HOME if not
function export_java_home_if_no(){
    sep
    echo "checking JAVA_HOME..."
    if [[ -z "${JAVA_HOME}" ]]; then
        echo "JAVA_HOME is not set, use default ${DEFAULT_JAVA_HOME}"
        export JAVA_HOME="${DEFAULT_JAVA_HOME}"
    else
       echo "JAVA_HOME is ${JAVA_HOME}" 
    fi
    sep
}

function setup_openam_sso_adm() {
  sep
  echo "checking if sso admin tools is set up or not.."
  local sso_cmd=${SSO_ADMIN_HOME}/sso/bin/ssoadm
  if [[ ! -d ${SSO_ADMIN_HOME} ]]; then
    echo "unzipping ${SSO_ADMIN_BINARY} to ${SSO_ADMIN_HOME} ..."
    sudo -u "${USER_RUNNING_CUR}" -E unzip "${SSO_ADMIN_BINARY}" -d "${SSO_ADMIN_HOME}"
  fi
  if [[ ! -f ${sso_cmd} ]]; then
    echo "${sso_cmd} is not found, try to set up..."
    #sudo -u ${USER_RUNNING_CUR} -E -s
    export_java_home_if_no
    cd ${SSO_ADMIN_HOME}
    echo "setting up sso admin tools, be patient..."
    sudo -u ${USER_RUNNING_CUR} -E sh ./setup -p "/var/wib/sso" -d "${SSO_ADMIN_HOME}/debug" -l "${SSO_ADMIN_HOME}/log" --acceptLicense
    if [[ $? -eq 0 ]]; then
      echo "completed sso admin setup"
    else
      err "failed to setup sso admin tools, Please fix it manully"
    fi
  else
    echo "${sso_cmd} was already setup."
  fi

  sep
}

#setup sso admin on CUR
function setup_ssoadm(){
  setup_openam_sso_adm
}

#set up python environment
function setup_py(){
  #check yum pkg
  install_yum_pkg_if_no "gcc"
  install_yum_pkg_if_no "python" 
  install_yum_pkg_if_no "python-devel"
  install_yum_pkg_if_no "python-ldap"
  install_yum_pkg_if_no "wget"
  install_yum_pkg_if_no "curl"

  #python modules which will be installed with pip
  install_py_pip_if_no
  install_py_mod_if_no "sqlalchemy"

  #oracle sdk and oracle python module
  export_java_home_if_no
  install_py_oracle_mod_if_no
}

#####main routine goes here##############################
[[ "$(whoami)" != "root" ]] && err "please run with sudo" && usage
if [[ $# -lt 1 ]]; then
  err "please specify at least one option"
  usage
fi

SETUP_PYTHON="false"
SETUP_SSOADM="false"
# -s to setup ssoadmin tools
# -p to setup python env
while getopts 'sp' OPT; do
  case $OPT in
    s)
      SETUP_SSOADM="true" 
      ;;
    p)
      SETUP_PYTHON="true" 
      ;;
    ?)
      usage
  esac
done
#shift $(($OPTIND - 1))

[[ "${SETUP_PYTHON}" = "true" ]] && setup_py
[[ "${SETUP_SSOADM}" = "true" ]] && setup_ssoadm
#comment wayang
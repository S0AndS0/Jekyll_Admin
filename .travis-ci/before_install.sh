#!/usr/bin/env bash
set -eE -o functrace


__SERVER_DEPENDENCIES__=(
    'unbound'
    'nginx'
    'git-core'
)


## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"
__PATH__="${__DIR__}/${__NAME__}"
__PARENT__="$(dirname "${__DIR__}")"
__AUTHOR__='S0AndS0'
__DESCRIPTION__='Simple dependencies installer for Debian based distributions'


#
# Source useful functions and write a few
#
source "${__PARENT__}/shared_functions/failure.sh"
trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR

source "${__PARENT__}/shared_functions/license.sh"


usage(){
    cat <<EOF
Installs any missing packages from: ${__SERVER_DEPENDENCIES__[*]}

$(__license__ "${__DESCRIPTION__}" "${__AUTHOR__}")
EOF
}


apt_deps_check(){
    ## Returns space separated string of package names that are not installed
    local _apt_deps_list=("${@:?${FUNCNAME[0]} not provided any package names}")
    local _apt_install_list=()
    for _apt_dep in "${_apt_deps_list[@]}"; do
        if ! dpkg -l "${_apt_dep}" 1>/dev/null 2>&1; then
            _apt_install_list+=("${_apt_dep}")
        fi
    done
    printf '%s' "${_apt_install_list[*]}"
}


#
# Do the things, maybe
#
if [ "${#@}" -gt '0' ]; then
    usage
    exit 1
fi


_deps_to_install="$(apt_deps_check "${__SERVER_DEPENDENCIES__[@]}")"
if [[ "${#_deps_to_install}" -le '0' ]]; then
    printf 'Nothing for %s to do, exiting without errors' "${__NAME__}"
    exit 0
fi


if [[ "${EUID}" == '0' ]]; then
    printf '# apt-get install -yq %s\n' "${_deps_to_install}"
    apt-get install -yq ${_deps_to_install}
else
    printf '# sudo apt-get install -yq %s\n' "${_deps_to_install}"
    sudo apt-get install -yq ${_deps_to_install}
fi

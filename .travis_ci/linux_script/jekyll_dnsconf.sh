#!/usr/bin/env bash
set -eE -o functrace

__JEKYLL_GROUP_NAMES__=('devs')
__DNS_CONF_DIR__='/etc/unbound/unbound.conf.d'
__GIT_DOWNLOAD_DIR__='/usr/local/etc'
__GIT_PROJECT_NAME__='Jekyll_Admin'


## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"
__PATH__="${__DIR__}/${__NAME__}"
__PARENT__="$(dirname "${__DIR__}")"
__TARGET_SCRIPT_PATH__="${__GIT_DOWNLOAD_DIR__}/${__GIT_PROJECT_NAME__}/.travis_ci/${__NAME__}"

__AUTHOR__='S0AndS0'
__DESCRIPTION__="Runs tests for script of same name: ${__NAME__}"


#
# Source useful functions and write a few
#
source "${__PARENT__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR

source "${__PARENT__}/shared_functions/license.sh"


usage(){
    _group_names="${__JEKYLL_GROUP_NAMES__[@]}"
    cat <<EOF
${__DESCRIPTION__}


Intended to be run by Travis CI (Continuous Integration) or similar services.

Does things with groups for; ${_group_names// /, }
 enabling Domain Name resoultion on a private network.

# Options

   -h    --help
Display this message and exit

   -l    --license
Display license for ${__NAME__} and exit
EOF
}


gen_group_domain(){
    local _group_name="${1:?${FUNCNAME[0]} not provided a user name}"
    local _tld="${2:?${FUNCNAME[0]} not provided a top level domain}"

    local _dns_conf_path="${__DNS_CONF_DIR__}/${_group_name}.${_tld}.conf"

    ## Attempt to make or modify DNS configs
    local _script_args=(
        '--server' 'unbound'
        '--domain' "${_group_name}"
        '--top-level-domain' "${_tld}"
        '--interface' 'lo'
    )
    if [ -f "${_dns_conf_path}" ]; then
        _script_args+=('--clobber' 'yes')
    fi

    printf 'sudo bash "%s" %s --help\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
    sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} --help
    return 2

    if [[ "${EUID}" == '0' ]]; then
        printf 'bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]}
    else
        printf 'sudo bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]}
    fi

    if ! [ -f "${_dns_conf_path}" ]; then
        printf 'Failed to write configuration file to %s\n' "${_dns_conf_path}"
        return 1
    fi
}


#
# Maybe do some things
#
if [ "${#@}" -gt '0' ] || [ "${TRAVIS_OS_NAME}" != 'linux' ]; then
    case "${1,,}" in
      *'license'|'-l')
          __license__ "${__DESCRIPTION__}" "${__AUTHOR__}"
          _exit_code='0'
      ;;
      *'help'|'-h')
          usage
          _exit_code='0'
      ;;
      *)
          usage
          printf '\nWarning - ${TRAVIS_OS_NAME} is %s\n' "${TRAVIS_OS_NAME}" >&2
          _exit_code='1'
      ;;
    esac
    exit "${_exit_code}"
fi


_top_level_domain='lan'
for _group_name in "${__JEKYLL_GROUP_NAMES__[@]}"; do
    gen_group_domain "${_group_name}" "${_top_level_domain}"

    _config_path="${__DNS_CONF_DIR__}/${_group_name}.${_top_level_domain}.conf"
    cat "${_config_path}"
done


printf '## %s finished\n' "${__NAME__}"

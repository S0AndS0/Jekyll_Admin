#!/usr/bin/env bash
set -eE -o functrace

__JEKYLL_USER_NAMES__=('Bill')
# __JEKYLL_USER_NAMES__=('Bill' 'Ted')
__NGINX_CONF_DIR__='/etc/nginx'
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
    _user_names="${__JEKYLL_USER_NAMES__[@]}"
    cat <<EOF
Intended to be run by Travis CI (Continuous Integration) or similar services.

Generates Web Server configurations for
 Git/Jekyll users; ${_user_names// /, }

# Options

   -h    --help
Display this message and exit

   -l    --license
Display license for ${__NAME__} and exit
EOF
}


gen_www_user_config(){
    local _user_name="${1:?${FUNCNAME[0]} not provided a user name}"
    local _group_name="${2:?${FUNCNAME[0]} not provided a user name}"
    local _tld="${3:?${FUNCNAME[0]} not provided a top level domain}"

    local _www_conf_path="${__NGINX_CONF_DIR__}/sites-available/${_user,,}.${_group}.${_tld}"

    ## Attempt to make or modify Web Server configs
    local _script_args=(
        '--server' 'nginx'
        '--interface' 'lo'
        '--user' "${_user_name}"
        '--domain' "${_group_name}"
        '--top-level-domain' "${_tld}"
        '--repo' "${_user_name}"
    )
    if [ -f "${_www_conf_path}" ]; then
        _script_args+=('--clobber' 'yes')
    fi

    if [[ "${EUID}" == '0' ]]; then
        bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} --help
        printf 'bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} || return "${?}"
    else
        sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} --help
        printf 'sudo bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} || return "${?}"
    fi

    if ! [ -f "${_www_conf_path}" ]; then
        printf 'Failed to write configuration file to %s\n' "${_www_conf_path}" >&2
        return 1
    fi

    printf '## %s finished' "${FUNCNAME[0]}"
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


_group_name='devs'
_tld='lan'
for _user_name in "${__JEKYLL_USER_NAMES__[@]}"; do
    gen_www_user_config "${_user_name}" "${_group_name}" "${_tld}"

    _config_path="${__NGINX_CONF_DIR__}/sites-available/${_user,,}.${_group}.${_tld}"
    cat "${_config_path}" || exit "${?}"
done


printf '## %s finished\n' "${__NAME__}"

#!/usr/bin/env bash


__GIT_PROJECT_NAME__='Jekyll_Admin'
__GIT_DOWNLOAD_DIR__='/usr/local/etc'
__GIT_CLONE_URL__='git@github.com:S0AndS0/Jekyll_Admin.git'


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
__DESCRIPTION__="Downloads ${__GIT_PROJECT_NAME__} via git clone"


#
# Source useful functions and write a few
#
source "${__PARENT__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR

source "${__PARENT__}/shared_functions/license.sh"


usage(){
    cat <<EOF
Intended for Debian based Linux distributions, fork this project to add more

Preforms git clone ${__GIT_CLONE_URL__}
Within ${__GIT_DOWNLOAD_DIR__}

# Options

    -h    --help
Display this message and exit

    -l    --license
Display license for ${__NAME__} and exit
EOF
}


maybe_git_clone(){
    local _download_dir="${1:?No git download directory provided}"
    local _project_name="${2:?No project name provided}"
    local _clone_url="${3:?No clone URL provided}"

    local _project_path="${_download_dir}/${_project_name}"
    if [ -d "${_project_path}/.git" ]; then
        printf 'Warning - %s detected preexisting %s\n' "${FUNCNAME[0]}" "${_project_path}"
        return 0
    fi

    mkdir -vp "${_download_dir}"
    cd "${_download_dir}" || return 1
    git clone ${_clone_url} || return 1

    printf '%s finished\n' "${FUNCNAME[0]}"
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

maybe_git_clone "${__GIT_DOWNLOAD_DIR__}" "${__GIT_PROJECT_NAME__}" "${__GIT_CLONE_URL__}"

printf '%s finished' "${__NAME__}"

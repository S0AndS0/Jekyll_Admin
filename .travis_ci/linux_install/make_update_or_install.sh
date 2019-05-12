#!/usr/bin/env bash


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
__AUTHOR__='S0AndS0'
__DESCRIPTION__="Runs make commands for ${__GIT_PROJECT_NAME__}"


#
# Source useful functions and write a few
#
source "${__PARENT__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR

source "${__PARENT__}/shared_functions/license.sh"


usage(){
    cat <<EOF
Intended for Debian based Linux distributions, fork this project to add more

# Options

    -h    --help
Display this message and exit

    -l    --license
Display license for ${__NAME__} and exit
EOF
}


maybe_make_install_or_update(){
    local _project_dir="${1:?No project directory provided}"

    if ! [ -d "${_project_dir}/.git" ]; then
        printf 'Error - %s cannot find .git directory under %s\n' "${FUNCNAME[0]}" "${_project_dir}" >&2
        return 1
    fi

    local _git_branches="$( { git branch; } 2>&1 )"
    local _current_branch="$(awk '/\* / {print $2}' <<<"${_git_branches}")"
    case "${_current_branch}" in
        'master')
            local _make_command='install'
        ;;
        *)
            if [ -z "${_current_branch}" ]; then
                printf 'Error - %s detected no git branches\n' "${FUNCNAME[0]}" >&2
                return 1
            else
                local _make_command='update'
            fi
        ;;
    esac
    make "${_make_command}" || return "${?}"

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

if ! [ -d "${__GIT_DOWNLOAD_DIR__}/${__GIT_PROJECT_NAME__}/.git" ]; then
    usage
    printf 'Error cannot find git directory\n' >&2
    exit 1
fi


maybe_make_install_or_update "${__GIT_DOWNLOAD_DIR__}" "${__GIT_PROJECT_NAME__}"

printf '%s finished' "${__NAME__}"

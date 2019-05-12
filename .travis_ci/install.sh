#!/usr/bin/env bash


__SCRIPT_NAME_LIST__=(
    'make_update_or_install.sh'
)


## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"
__PATH__="${__DIR__}/${__NAME__}"
__TARGET_SCRIPTS_DIR__="${__DIR__}/${__NAME__%.*}"
__AUTHOR__='S0AndS0'
__DESCRIPTION__="Runs scripts under directory ${TRAVIS_OS_NAME}_${__NAME__%.*}"


#
# Source useful functions and write a few
#
source "${__DIR__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR


source "${__DIR__}/shared_functions/license.sh"
source "${__DIR__}/shared_functions/run_scripts_under_dir.sh"


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


#
# Maybe do some things
#
if [ "${#@}" -gt '0' ] || [ -z "${TRAVIS_OS_NAME}" ]; then
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


run_scripts_under_dir "${__TARGET_SCRIPTS_DIR__}" '__SCRIPT_NAME_LIST__'

printf '%s finished' "${__NAME__}"

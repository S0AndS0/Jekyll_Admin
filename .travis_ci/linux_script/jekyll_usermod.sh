#!/usr/bin/env bash

__JEKYLL_USER_NAMES__=('Bill')
# __JEKYLL_USER_NAMES__=('Bill' 'Ted')
__SSH_KEY_DIR__="${HOME}/.ssh/git_users"
__RUBY_TARGET_VERSION__='2.4.0'
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
${__DESCRIPTION__}


Intended to be run by Travis CI (Continuous Integration) or similar services.

Generates SSH key pares and sets up Git/Jekyll user
 accounts for; ${_user_names// /, }

# Options

   -h    --help
Display this message and exit

   -l    --license
Display license for ${__NAME__} and exit
EOF
}


user_install_ruby(){
    local _user_name="${1:?No user name provided}"
    local _ruby_version="${2:?No Ruby version provided}"

    sudo su --shell /bin/bash - "${_user_name}" <<EOF
rvm install ${_ruby_version} --disable-binary || exit "\${?}"
ls -hal \${HOME}/.rvm/rubies/ || exit "\${?}"
EOF
    local _exit_code="${?}"
    if ((_exit_code)); then
        printf '%s detected error code %i\n' "${FUNCNAME[0]}" "${_exit_code}"
        return "${_exit_code}"
    fi

    printf '%s finished\n' "${FUNCNAME[0]}"
}


gen_ssh_keys(){
    ## Thanks be to
    ##  https://github.com/rvm/rvm/issues/1244
    local _key_name="${1:?No key name provided}"
    local _key_dir="${2:-$__SSH_KEY_DIR__}"

    local _key_path_private="${_key_dir}/${_key_name}"
    local _key_path_public="${_key_path_public}.pub"

    if [ -f "${_key_path_private}" ] || [ -f "${_key_path_public}" ]; then
        printf 'Warning - %s or %s already exsist\n    Not generating new ones...\n' "${_key_path_private}" "${_key_path_public}"
        return 0
    fi

    printf "ssh-keygen -t ecdsa -f \"%s\" -C '' -N ''\n" "${_key_path_private}"
    ssh-keygen -t ecdsa -f "${_key_path_private}" -C '' -N '' || return "${?}"

    printf '## %s finished' "${FUNCNAME[0]}"
}


append_ssh_config(){
    local _user_name="${1:?No user name provided}"
    local _key_path_private="${2:-${__SSH_KEY_DIR__}/${_user_name,,}}"
    local _host_name="${3:-${_user_name}}"

    if [ -f "${_key_path_private}" ]; then
        printf 'Error - %s does not exsist!\n' "${_key_path_private}"
        return 1
    fi

    tee -a "${HOME}/.ssh/config" 1>/dev/null <<EOF
Host ${_host_name}
    IdentitiesOnly yes
    IdentityFile "${_key_path_private}"
    HostName localhost
    User ${_user_name}
EOF

    printf '## %s finished' "${FUNCNAME[0]}"
}


gen_jekyll_user(){
    ## Generates SSH keys and sets-up new
    ##  Jekyll/Git user with the new key.
    local _user_name="${1:?${FUNCNAME[0]} not provided a user name}"
    local _ssh_dir="${2:?${FUNCNAME[0]} not provided a directory path}"

    local _ssh_private_key="${_ssh_dir}/${_user_name,,}"
    local _ssh_pub_key="${_ssh_private_key}.pub"

    ## Attempt to make Jekyll/Git user
    local _script_args=(
        '--user' "${_user_name}"
        '--ssh-pub-key' "${_ssh_pub_key}"
    )

    if [[ "${EUID}" == '0' ]]; then
        bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} --help
        printf 'bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} || return "${?}"
    else
        sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} --help
        printf 'sudo bash "%s" %s\n' "${__TARGET_SCRIPT_PATH__}" "${_script_args[*]}"
        sudo bash "${__TARGET_SCRIPT_PATH__}" ${_script_args[*]} || return "${?}"
    fi

    user_install_ruby "${_user_name}" "${__RUBY_TARGET_VERSION__}" || return "${?}"

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


[[ -d "${__SSH_KEY_DIR__}" ]] || mkdir -vp "${__SSH_KEY_DIR__}"

for _user_name in "${__JEKYLL_USER_NAMES__[@]}"; do
    gen_ssh_keys "${_user_name,,}" "${__SSH_KEY_DIR__}"
    append_ssh_config "${_user_name}" "${__SSH_KEY_DIR__}/${_user_name,,}"
    gen_jekyll_user "${_user_name}" "${__SSH_KEY_DIR__}"

    _home="/srv/${_user_name,,}"
    if ! [ -d "${_home}" ]; then
        printf 'Error - could not make home %s for %s\n' "${_home}" "${_user_name}" >&2
        exit 1
    fi

    printf 'Listing %s home %s\n' "${_user_name}" "${_home}"
    ls -hal "${_home}" || exit "${?}"
done

printf '## %s finished' "${__NAME__}"

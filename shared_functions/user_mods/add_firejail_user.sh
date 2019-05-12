#!/usr/bin/env bash


add_firejail_user(){    ## add_firejail_user <user> sub_shell_path
    local _user="${1:?No user name provided}"
    local _shell="${2:-$(which git-shell)}"
    local _firejail_conf_dir="$(which firejail | sed 's/bin/etc/')"

    [[ -d "${_firejail_conf_dir}" ]]                || return 1
    [[ -f "${_firejail_conf_dir}/login.users" ]]    || return 1
    [[ -f "${_firejail_conf_dir}/firejail.users" ]] || return 1
    [[ -e "${_git_shell}" ]]                        || return 1

    if ! grep -q -- "${_user}" "${_firejail_conf_dir}/firejail.users"; then
        printf 'Appending "%s" to: %s/firejail.users\n' "${_user}" "${_firejail_conf_dir}"
        tee -a "${_firejail_conf_dir}/firejail.users" 1>/dev/null <<<"${_user}"
    fi
    if ! grep -q -- "${_user}" "${_firejail_conf_dir}/login.users"; then
        printf 'Appending "%s:--shell=%s" to: %s/login.users\n' "${_user}" "${_shell}" "${_firejail_conf_dir}"
        tee -a "${_firejail_conf_dir}/login.users" 1>/dev/null <<<"${_user}:--shell=${_shell}"
    fi

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

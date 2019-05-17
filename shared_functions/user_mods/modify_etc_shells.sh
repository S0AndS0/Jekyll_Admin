#!/usr/bin/env bash


modify_etc_shells(){    ## modify_etc_shells <shell_path>
    _login_shell="${1:?No login shell path provided}"
    _git_shell="$(which git-shell)"

    if [[ "${_git_shell}" != "${_login_shell}" ]]; then
        printf '%s not yet coded to add shell %s to /etc/shells\n' "${FUNCNAME[0]}" "${_login_shell}" >&2
        return 1
    fi
    if  ! [ -e "${_login_shell}" ]; then
        printf '%s is not executable!\n' "${_login_shell}" >&2
        return 1
    fi

    if ! grep -q -- "${_login_shell}" '/etc/shells'; then
        printf 'Adding %s to /etc/shells\n' "${_login_shell}"
        tee -a /etc/shells 1>/dev/null <<<"${_login_shell}"
    fi

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

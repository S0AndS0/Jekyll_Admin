#!/usr/bin/env bash


modify_etc_shells(){    ## modify_etc_shells <shell_path>
    _login_shell="${1:?No login shell path provided}"
    _git_shell="$(which git-shell)"
    ## Add 'git-shell' to available shells if not already available
    if [ -e "${_git_shell}" ] && [[ "${_git_shell}" == "${_login_shell}" ]]; then
        if ! grep -q -- "${_git_shell}" '/etc/shells'; then
            printf 'Adding %s to /etc/shells\n' "${_git_shell}"
            tee -a /etc/shells 1>/dev/null <<<"${_git_shell}"
        fi
    else
        printf 'modify_etc_shells not yet coded to add shell %s to /etc/shells\n' "${_login_shell}" >&2
        return 1
    fi

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

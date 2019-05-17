#!/usr/bin/env bash


add_jekyll_user(){    ## add_jekyll_user <user>:group <shell_path> additional_groups home_base
    local _user_group="${1:?No user:group name provided}"
    local _user="${_user_group%%[ :]*}"
    local _group="$(awk -F'[ :]' '{print $2}' <<<"${_user_group}")"
    # _group=${_user_group##*[ :]};
    ## Note, above will throw-off some syntax highlighters if quoted
    ##  Atom so far, and if there is not a semicolon after... hence
    ##  why for the awk and bellow re-assignment.
    local _group="${_group:-$_user}"
    local _shell="${2:?No shell path provided}"
    local _additional_groups="${3}"
    local _base_home_dir="${4:-/srv}"
    local _home="${_base_home_dir}/${_user,,}"
    if grep -qiE -- "^${_user}:" '/etc/passwd'; then
        printf 'User %s already exists\n' "${_user}" >&2
        return 1
    fi

    if ! getent group "${_group}" 1>/dev/null; then
        printf 'Adding group %s\n' "${_group}"
        groupadd "${_group}" || return "${?}"
    fi
    ## Relaxed regex from defaults to allow capitalization in usernames
    NAME_REGEX='^[a-zA-Z][-a-zA-Z0-9]*$' adduser\
     --force-badname\
     --system\
     --disabled-password\
     --gecos ''\
     --shell "${_shell}"\
     --home "${_home,,}"\
     --ingroup ${_group}\
     ${_user} || return "${?}"

    if [ -n "${_additional_groups}" ]; then
        ## Add any additional groups that do not exist yet
        for _additional_group in ${_additional_groups//,/ }; do
            if getent 'group' "${_additional_group}" 1>/dev/null; then continue; fi
            printf 'Adding group %s\n' "${_additional_group}"
            groupadd "${_additional_group}" || return "${?}"
        done
        ## Add list of additional groups to user
        usermod -a -G "${_additional_groups}" "${_user}" || return "${?}"
    fi

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

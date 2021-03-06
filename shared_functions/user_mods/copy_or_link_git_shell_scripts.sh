#!/usr/bin/env bash


copy_or_link_git_shell_commands(){    ## copy_or_link_git_shell_commands <user> allowed_scripts copy_or_link clobber
    _user="${1:?No user name provided}"
    _allowed_scripts="${2:-all}"
    _copy_or_link="${3:-copy}"
    _clobber="${4:-no}"

    _group="$(groups ${_user} | awk '{print $3}')"
    _script_dir="${__DIR__}/git-shell-commands"
    _available_scripts="$(find "${_script_dir}" -type f)"
    _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    if ! [ -d "${_home}" ]; then
        printf 'Cannot locate home directory for %s\n' "${_user}" >&2
        return 1
    fi

    if [[ "${_allowed_scripts,,}" == 'none' ]] || [[ -z "${_allowed_scripts,,}" ]]; then
        if [[ "${_allowed_scripts,,}" == 'none' ]] && [[ "${_clobber,,}" == 'yes' ]] && [ -d "${_home}/git-shell-commands" ]; then
            printf 'Notice - allowed scripts set to %s, clobber set to %s, and pre-existing git-shell-commands directory detected\n' "${_allowed_scripts,,}" "${_clobber,,}"
            rm -rfv "${_home}/git-shell-commands"
            return 0
        fi
        printf 'Skipping coping or linking of git shell commands for %s\n' "${_user}"
        return 0
    fi

    mkdir -vp "${_home}/git-shell-commands"
    if [[ "${_allowed_scripts,,}" == 'all' ]]; then
        case "${_copy_or_link,,}" in
            'copy'|'pushable')
                cp -vr ${_script_dir}/* "${_home}/git-shell-commands/"
            ;;
            *)
                for _f in $(ls -1 "${_script_dir}"); do
                    _source_path="${_script_dir}/${_f}"
                    [[ -f "${_source_path}" ]] || continue
                    ln -sv "${_source_path}" "${_home}/git-shell-commands/"
                done
            ;;
        esac
    else
        for _script_path in ${_available_scripts}; do
            for _chosen in ${_allowed_scripts//,/ }; do
                [[ "${_chosen}" == "${_script_path##*/}" ]] || continue
                if [[ "${_copy_or_link,,}" == 'copy' ]] || [[ "${_copy_or_link,,}" == 'pushable' ]]; then
                    cp -v "${_script_path}" "${_home}/git-shell-commands/"
                elif [[ "${_copy_or_link,,}" == 'link' ]]; then
                    ln -sv "${_script_path}" "${_home}/git-shell-commands/"
                fi
            done
        done
        if [[ "${#_allowed_scripts}" -gt '0' ]]; then
            case "${_copy_or_link,,}" in
                'copy'|'pushable')
                    cp -vr "${_script_dir}/shared_functions" "${_home}/git-shell-commands/"
                ;;
            esac
        fi
    fi

    if [[ -f "${_home}/git-shell-commands/.git" ]]; then
        rm "${_home}/git-shell-commands/.git"
    fi

    case "${_copy_or_link,,}" in
        'pushable')
            chmod 750 "${_home}/git-shell-commands"
            chown --recursive "${_user}":"${_group}" "${_home}/git-shell-commands"
            find "${_home}/git-shell-commands" -type f -exec chmod 740 {} \;
            find "${_home}/git-shell-commands" -type d -exec chmod 750 {} \;
            su --shell $(which bash) --login ${_user} <<'EOF'
_old_PWD="${PWD}"
cd "${HOME}/git-shell-commands"
git init .
git config receive.denyCurrentBranch updateInstead
git add --all
git -c user.name="${USER}" -c user.email="${USER}@${HOSTNAME}" commit -m "Added git-shell-commands to git tracking and allowed pushing for ${USER}"
cd "${_old_PWD}"
EOF
            local _exit_status="${?}"
            if ((_exit_status)); then return "${_exit_status}"; fi
        ;;
        *)
            chmod 550 "${_home}/git-shell-commands"
            chown --recursive "${_user}":"${_group}" "${_home}/git-shell-commands"
            find "${_home}/git-shell-commands" -type f -exec chmod 540 {} \;
            find "${_home}/git-shell-commands" -type d -exec chmod 550 {} \;
        ;;
    esac

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

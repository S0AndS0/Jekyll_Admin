#!/usr/bin/env bash


add_ssh_pub_key(){    ## add_ssh_pub_key <user> <pub_key>
    local _user="${1:?No user name provided}"
    local _pub_ssh_key="${2:?No authorized keys provided}"

    local _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    local _authorized_keys_path="${_home}/.ssh/authorized_keys"

    if [ -f "${_authorized_keys_path}" ]; then
        printf 'SSH authorized_keys file already exists for %s\n' "${_user}" >&2
        return 1
    fi

    local _group="$(groups ${_user} | awk '{print $3}')"
    mkdir -vp "${_home}/.ssh" || return 1

    if [ -f "${_pub_ssh_key}" ]; then
        tee -a "${_authorized_keys_path}" 1>/dev/null <<<"$(<"${_pub_ssh_key}")"
    else
        case "${_pub_ssh_key}" in
            *'ssh-rsa'*|*'ssh-dsa'*|*'ssh-ecdsa'*|*'ssh-ed25519'*)
                tee -a "${_authorized_keys_path}" 1>/dev/null <<<"$(printf '%s\n' "${_pub_ssh_key}")"
            ;;
            *)
                echo 'String did not match known authorized_keys format' >&2
                return 1
            ;;
        esac
    fi

    ## Set correct permissions and ownership for directory and authorized_keys file
    chmod -v 600 "${_home}/.ssh/authorized_keys"
    chmod -v 700 "${_home}/.ssh"
    chown -vR "${_user}":"${_group}" "${_home}/.ssh"

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

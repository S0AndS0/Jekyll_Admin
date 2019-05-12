#!/usr/bin/env bash


_NGINX_CONF_DIR="${_NGINX_CONF_DIR:-/etc/nginx}"


nginx_write_config(){    ## nginx_write_config <user>:group <repo> tld interface clobber
    local _user_domain="${1:?No user:domain provided}"
    local _user="${_user_domain%%:*}"
    local _domain="${_user_domain##*:}"
    _domain="${_domain:-$(groups ${_user} | awk '{print $3}')}"
    local _repo="${2:?No repository name provided}"
    local _tld="${3:-lan}"
    local _interface="${4:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
    local _clobber="${5:-no}"

    local _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    local _server_name="${_user,,}.${_domain}.${_tld} www.${_user,,}.${_domain}.${_tld}"
    local _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_domain}.${_tld}"

    if [[ "${_user,,}" == "${_repo,,}" ]]; then
        local _www_dir="${_home}/www/${_user}"
    else
        local _www_dir="${_home}/www/${_repo}"
    fi
    if ! [ -d "${_www_dir}" ] && [[ "${_clobber,,}" != 'force' ]]; then
        printf 'Try "ssh %s@host-or-ip jekyll-build %s" first\n' "${_user}" "${_repo}" >&2
        return 1
    fi

    if [ -f "${_sites_available_path}" ]; then
        case "${_clobber,,}" in
            'yes'|'append'|'force')
                printf 'NOTICE - Nginx sites-available config already exists, clobber set to %s\n' "${_clobber,,}"
            ;;
            *)
                printf 'Error - Nginx sites-available config already exists, clobber set to %s\n' "${_clobber,,}" >&2
                return 1
            ;;
        esac
    fi

    if [ -f "${_sites_available_path}" ]; then
        local _conf="$(<"${_sites_available_path}")"
        local _header="${_conf%\}*}"
    else
        local _header="$(nginx_print_config_header "${_user}" "${_domain}" "${_tld}" "${_interface}" 'new')"
    fi
    if [ -z "${_header}" ]; then
        printf 'Could not find or generate header for %s\n' "${_sites_available_path}" >&2
        return 1
    fi

    if [[ "${_user,,}" != "${_repo,,}" ]]; then
        local _match_location="/${_repo}/"
        read -r -d '' _location <<EOF
    location ${_match_location} {
        root "${_www_dir%/*}";
        try_files \$uri \$uri/ =404;
        error_page 404 /${_repo}/404.html;
    }
EOF
        ## Search for pre-existing configuration for repository
        if [ -f "${_sites_available_path}" ] && grep -q -- "${_match_location}" "${_sites_available_path}"; then
            printf 'Location config for %s already exists within %s\n' "${_repo}" "${_sites_available_path}" >&2
            return 1
        fi
        read -r -d '' _new_conf <<EOF
${_header}
    ${_location}
}
## Notice - everything beyond above line is subject to auto-removal
EOF
    else
        local _www_path="${_home}/www/${_user}"
        ## Search for pre-existing configuration for repository
        if [ -f "${_sites_available_path}" ] && grep -q -- "${_www_path}" "${_sites_available_path}"; then
            printf 'Location config for %s already exists within %s\n' "${_repo}" "${_sites_available_path}" >&2
            return 1
        fi
        read -r -d '' _new_conf <<EOF
${_header}
}
## Notice - everything beyond above line is subject to auto-removal
EOF
    fi

    [[ -n "${_new_conf}" ]] && tee "${_sites_available_path}" 1>/dev/null <<<"${_new_conf}"
    printf '## %s finished\n' "${FUNCNAME[0]}"
}

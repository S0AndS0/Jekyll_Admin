#!/usr/bin/env bash


_NGINX_CONF_DIR="${_NGINX_CONF_DIR:-/etc/nginx}"

## Enable sourcing from project root
if [ -z "${__GGG_PARENT__}" ]; then
    __SOURCE__="${BASH_SOURCE[0]}"
    while [[ -h "${__SOURCE__}" ]]; do
        __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
    done
    __SUB_DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
    __GGG_PARENT__="$(dirname "$(dirname "$(dirname "${__SUB_DIR__}")")")"
fi

## Provides: nginx_enable_config <path>
source "${__GGG_PARENT__}/shared_functions/web_servers/nginx/nginx_enable_config.sh"

## Provides: nginx_print_config_header <user> <domain> tld interface clobber
source "${__GGG_PARENT__}/shared_functions/web_servers/nginx/nginx_print_config_header.sh"


nginx_rewrite_config(){    ## nginx_rewrite_config <user> <domain> tld interface clobber
    local _user="${1:?No user name provided}"
    local _domain="${2:?No domain/group name provided}"
    local _tld="${3:-lan}"
    local _interface="${4:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
    local _clober="${5:-update}"
    local _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    if [ -z "${_home}" ]; then
        printf 'No home found for %s\n' "${_user}" >&2
        return 1
    fi
    local _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_domain}.${_tld}"
    local _header="$(nginx_print_config_header "${_user}" "${_domain}" "${_tld}" "${_interface}" "${_clobber}")"

    for _sub_dir in "${_home}/www/"*; do
        _repo="${_sub_dir##*/}"
        [[ -f "${_home}/www/${_repo}" ]] && continue
        [[ "${_repo}" == "${_user}" ]] && continue
        [[ -d "${_home}/git/${_repo}" ]] || continue
        read -r -d '' _new_conf <<EOF
${_new_conf}

    location /${_repo}/ {
        root "${_home}/www";
        try_files \$uri \$uri/ =404;
                error_page 404 /${_repo}/404.html;
    }
EOF
    done

    read -r -d '' _new_conf <<EOF
${_new_conf}
}
## Notice - everything beyond above line is subject to auto-removal
EOF

    tee "${_sites_available_path}" 1>/dev/null <<<"${_new_conf}" || return 1
    nginx_enable_config "${_sites_available_path}" || return 1

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

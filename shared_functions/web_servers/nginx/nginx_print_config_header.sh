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

## Provides:
##    interface_ipv4 <interface>
##    interface_ipv6 <interface>
source "${__GGG_PARENT__}/shared_functions/network_info.sh"


nginx_print_config_header(){    ## nginx_print_config_header <user> <domain> tld interface clobber
    local _user="${1:?No user name provided}"
    local _domain="${2:?No domain name provided}"
    local _tld="${3:-lan}"
    local _interface="${4}"
    local _clobber="${5:-no}"
    local _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_group}.${_tld}"

    case "${_clobber,,}" in
        'rewrite'|'new')
            local _interface="${_interface:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
            case "${_interface,,}" in
                'all')
                    lsmod | grep -q -- 'ipv4' && local _listen_ipv4='listen 0.0.0.0'
                    lsmod | grep -q -- 'ipv6' && local _listen_ipv6='listen [::]'
                ;;
                *)
                    local _ipv4="$(interface_ipv4 "${_interface}")"
                    local _ipv6="$(interface_ipv6 "${_interface}")"
                    _ipv4="${_ipv4%/*}"
                    _ipv6="${_ipv6%/*}"
                    if [[ -z "${_ipv4}" ]] && [[ -z "${_ipv6}" ]]; then
                        printf 'Error - cannot find IP address for %s\n' "${_interface}" >&2
                        return 1
                    fi
                    [[ -n "${_ipv4}" ]] && local _listen_ipv4="listen ${_ipv4}"
                    [[ -n "${_ipv6}" ]] && local _listen_ipv6="listen [${_ipv6}]"
                ;;
            esac

            read -r -d '' _header <<EOF
server {
    location ~ /.git/ { deny all; }
    ${_listen_ipv4:-# listen 0.0.0.0}:80;
    ${_listen_ipv6:-# listen \[::\]}:80;
    server_name ${_user,,}.${_domain}.${_tld} www.${_user,,}.${_domain}.${_tld};
    index index.html index.htm;
    root "${_home}/www/${_user}";
    error_page 404 /404.html;
    location / { try_files \$uri \$uri/ =404; }
EOF
        ;;
        *)
            ## The following is ugly but preserves stuff before
            ##  first repository location configuration block.
            local _start_line_number="$(grep -nE -- 'server {' "${_sites_available_path}" | head -1 | awk -F':' '{print $1}')"
            local _till_line_count="$(gawk -v _s='server \{' -v _e='(    |\t)location \/[a-zA-Z0-9_-]*\/ \{'\
                                     '$0 ~ _s, $0 ~ _e {print} {if ($0 ~ _s) _t=1} {if ($0 ~ _e && _t==1) exit}'\
                                     "${_sites_available_path}" | wc -l)"
            ((_till_line_count--))

            local _header="$(sed -n "${_start_line_number},${_till_line_count}p" "${_sites_available_path}")"
        ;;
    esac

    printf '%s\n' "${_header}"
}

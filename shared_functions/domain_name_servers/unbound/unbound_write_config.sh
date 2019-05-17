#!/usr/bin/env bash


_DNS_CONF_DIR="${_DNS_CONF_DIR:-/etc/unbound/unbound.conf.d}"


## Enable sourcing from project root
if [ -z "${__GGG_PARENT__}" ]; then
    __SOURCE__="${BASH_SOURCE[0]}"
    while [[ -h "${__SOURCE__}" ]]; do
        __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
    done
    __SUB_DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
    __GGG_PARENT__="$(dirname "$(dirname "$(dirname "${__SUB_DIR__}")")")"
fi


## Provides: unbound_write_ip_config <ip> <url>
source "${__GGG_PARENT__}/shared_functions/domain_name_servers/unbound/unbound_write_ip_config.sh"

## Provides:
#    interface_ipv4 <interface>
#    interface_ipv6 <interface>
source "${__GGG_PARENT__}/shared_functions/network_info.sh"


## By default everything is served under the group domain with users being
##  sub-domains under that, thus one only needs to configure local DNS
##  resolution to the group domain and have the web server handle user and
##  repository specific url to directory path resolution.
unbound_write_config(){    ## unbound_write_config <domain> <tld> interface clobber
    _domain="${1:?No domain name provided}"
    _tld="${2:?No Top Level Domain name provided}"
    _interface="${3:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
    _clobber="${4:-no}"

    _ipv4="$(interface_ipv4 "${_interface}")"
    _ipv6="$(interface_ipv6 "${_interface}")"
    _ipv4="${_ipv4%/*}"
    _ipv6="${_ipv6%/*}"

    if [ -z "${_ipv4}" ] && [ -z "${_ipv6}" ]; then
        printf 'Error - no IP address detected for %s interface\n' "${_interface}" >&2
        return 1
    fi

    _url="${_domain}.${_tld}"
    _dns_conf_path="${_DNS_CONF_DIR}/${_domain}.${_tld}.conf"

    [[ -d "$(dirname "${_DNS_CONF_DIR}")" ]] || return 1
    mkdir -vp "${_DNS_CONF_DIR}"

    if [[ -f "${_dns_conf_path}" ]]; then
        case "${_clobber,,}" in
            'yes'|'append')
                printf '# Notice - configuration file %s is being appended to\n' "${_dns_conf_path}"
            ;;
            *)
                printf '# Error - configuration file %s already exists\n' "${_dns_conf_path}" >&2
                return 1
            ;;
        esac
    else
        ## Initialize configuration file otherwise
        tee "${_dns_conf_path}" 1>/dev/null <<EOF
server:
    private-domain: "${_domain}.${_tld}."
    local-zone: "${_domain}.${_tld}." static
EOF
    fi

    if [ -n "${_ipv4}" ]; then
        unbound_write_ip_config "${_ipv4}" "${_url}" "${_dns_conf_path}"
    else
        echo '# No IPv4 address detected'
    fi

    if [ -n "${_ipv6}" ]; then
        unbound_write_ip_config "${_ipv6}" "${_url}" "${_dns_conf_path}"
    else
        echo '# No IPv6 address detected'
    fi

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

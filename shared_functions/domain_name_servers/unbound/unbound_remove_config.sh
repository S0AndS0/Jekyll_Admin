#!/usr/bin/env bash


_DNS_CONF_DIR="${_DNS_CONF_DIR:-/etc/unbound/unbound.conf.d}"


## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__SUB_DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__GGG_PARENT__="$(dirname "$(dirname "$(dirname "${__SUB_DIR__}")")")"


## Provides: remove_from_to <search-start> <search-end> <file-path>
source "${__G_PARENT__}/remove_from_to.sh"

## Provides:
#    interface_ipv4 <interface>
#    interface_ipv6 <interface>
source "${__G_PARENT__}/network_info.sh"


remove_unbound_config(){    ## remove_unbound_config <domain> <tld> interface clobber
    local _domain="${1:?No domain name provided}"
    local _tld="${2:?No Top Level Domain name provided}"
    local _interface="${3:-all}"
    local _clobber="${4:-no}"
    local _dns_conf_path="${_DNS_CONF_DIR}/${_domain}.conf"

    case "${_clobber,,}" in
        'remove')
            local _url="${_domain}.${_tld}"

            if [ -z "${_interface}" ] || [ "${_interface,,}" == 'all' ]; then
                local _ipv4="([0-9][.]){3}[0-9]"
                local _ipv6="(([0-9]|[a-f]){0,4}:){5,7}([0-9]|[a-f]){0,4}"
            else
                local _ipv4="$(interface_ipv4 "${_interface}")"
                local _ipv6="$(interface_ipv6 "${_interface}")"
            fi

            if [ -z "${_ipv4}" ] && [ -z "${_ipv6}" ]; then
                printf 'Error - no IP address detected for %s interface\n' "${_interface}" >&2
                return 1
            fi

            if [ -n "${_ipv4}" ]; then
                local _ipv4_search_start="${_url}.[\t ]+IN[\t ]+A[\t ]+${_ipv4}"
                local _ipv4_search_end="${_ipv4}[\t ]+${_url}."
                remove_from_to "${_ipv4_search_start}" "${_ipv4_search_end}" "${_dns_conf_path}"
            fi
            if [ -n "${_ipv6}" ]; then
                local _ipv6_search_start="${_url}.[\t ]+IN[\t ]+A[\t ]+${_ipv6}"
                local _ipv6_search_end="${_ipv6}[\t ]+${_url}."
                remove_from_to "${_ipv6_search_start}" "${_ipv6_search_end}" "${_dns_conf_path}"
            fi
        ;;
        'delete')
            [[ -f "${_dns_conf_path}" ]] && rm -v "${_dns_conf_path}"
        ;;
        *)
            printf 'Error - clobber set to %s\n' "${_clobber}" >&2
            return 1
        ;;
    esac

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

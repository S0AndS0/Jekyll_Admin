#!/usr/bin/env bash
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo source ${0##*/}"; exit 1; fi
## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__SUB_DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"

## Provides:    remove_from_to <search-start> <search-end> <file-path>
source "${__SUB_DIR__}/clobber_config.sh"

## Provides:    interface_ipv4 <interface>
#        interface_ipv6 <interface>
source "${__SUB_DIR__}/network_info.sh"

_DNS_CONF_DIR="/etc/unbound/unbound.conf.d"


remove_unbound_config(){
    _user_group="${1:?No user:domain provided}"
    _user="${_user_group%%:*}"
    _group="${_user_group##*:}"
    _group="${_group:-(groups ${_user} | awk '{print $3}')}"
    _tld="${2:?No Top Level Domain name provided}"
    _interface="${3:-all}"
    _clobber="${4:-no}"
    _dns_conf_path="${_DNS_CONF_DIR}/${_group}.conf"

    case "${_clobber,,}" in
        'remove')
            if [[ "${_user}" == "${_group}" ]]; then
                _url="${_group}.${_tld}"
            else
                _url="${_user}.${_group}.${_tld}"
            fi

            if [ -z "${_interface}" ] || [ "${_interface,,}" == 'all' ]; then
                _ipv4="([0-9][.]){3}[0-9]"
                _ipv6="(([0-9]|[a-f]){0,4}:){5,7}([0-9]|[a-f]){0,4}"
            else
                _ipv4="$(interface_ipv4 "${_interface}")"
                _ipv6="$(interface_ipv6 "${_interface}")"
            fi

            if [ -n "${_ipv4}" ]; then
                _ipv4_search_start="${_url}.[\t ]+IN[\t ]+A[\t ]+${_ipv4}"
                _ipv4_search_end="${_ipv4}[\t ]+${_url}."
                remove_from_to "${_ipv4_search_start}" "${_ipv4_search_end}" "${_dns_conf_path}"
            fi
            if [ -n "${_ipv6}" ]; then
                _ipv6_search_start="${_url}.[\t ]+IN[\t ]+A[\t ]+${_ipv6}"
                _ipv6_search_end="${_ipv6}[\t ]+${_url}."
                remove_from_to "${_ipv6_search_start}" "${_ipv6_search_end}" "${_dns_conf_path}"
            fi
        ;;
        'delete')
            [[ -f "${_dns_conf_path}" ]] && rm -v "${_dns_conf_path}"
        ;;
        *)
            printf 'ERROR - clobber set to %s\n' "${_clobber}"
            exit 1
        ;;
    esac
    echo '## remove_unbound_config finished'
}

## By default everything is served under the group domain with users being
##  sub-domains under that, thus one only needs to configure local DNS
##  resolution to the group domain and have the web server handle user and
##  repository specific url to directory path resolution.
write_unbound_config(){    ## write_unbound_config group tld interface clobber
    _user_group="${1:?No user:domain provided}"
    _user="${_user_group%%:*}"
    _group="${_user_group##*:}"
    _group="${_group:-(groups ${_user} | awk '{print $3}')}"
    # _group="${1:?No group/domain name provided}"
    _tld="${2:?No Top Level Domain name provided}"
    _interface="${3:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
    _clobber="${4:-no}"

    _ipv4="$(interface_ipv4 "${_interface}")"
    _ipv6="$(interface_ipv6 "${_interface}")"

    if [[ "${_user}" == "${_group}" ]]; then
        _url="${_group}.${_tld}"
    else
        _url="${_user,,}.${_group}.${_tld}"
    fi

    _dns_conf_path="${_DNS_CONF_DIR}/${_group}.${_tld}.conf"
    if [[ -f "${_dns_conf_path}" ]]; then
        case "${_clobber,,}" in
            'yes')
                printf '# Notice - configuration file %s is being appended to\n' "${_dns_conf_path}"
            ;;
            *)
                printf '# Error - configuration file %s already exists\n' "${_dns_conf_path}"
                return 1
            ;;
        esac
    else
        ## Initialize configuration file otherwise
        tee "${_dns_conf_path}" 1>/dev/null <<-EOF
        server:
            private-domain: "${_group}.${_tld}."
            local-zone: "${_group}.${_tld}." static
        EOF
    fi

    if [ -n "${_ipv4}" ]; then
        read -r -d '' _ipv4_config <<-EOF
            local-data: "${_url}.      IN A    ${_ipv4}"
            local-data-ptr: "${_ipv4}    ${_url}."
        EOF
        ## Unbound really does not take kindly to duplicate entries
        if ! grep -q -- "$(tail -1 <<<"${_ipv4_config}")" "${_dns_conf_path}" 2>/dev/null; then
            tee -a "${_dns_conf_path}" 1>/dev/null <<<"    ${_ipv4_config}"
        else
            printf '# Configuration block for %s already exists in %s\n' "${_group}" "${_dns_conf_path}"
        fi
    else
        echo '# No IPv4 address detected'
    fi
    if [ -n "${_ipv6}" ]; then
        read -r -d '' _ipv6_config <<-EOF
            local-data: "${_url}.      IN A    ${_ipv6}"
            local-data-ptr: "${_ipv6}    ${_url}."
        EOF
        if ! grep -q -- "$(tail -1 <<<"${_ipv6_config}")" "${_dns_conf_path}" 2>/dev/null; then
            tee -a "${_dns_conf_path}" 1>/dev/null <<<"    ${_ipv6_config}"
        else
            printf '# Error - configuration block for %s already exists in %s\n' "${_group}" "${_dns_conf_path}"
        fi
    else
        echo '# No IPv6 address detected'
    fi
    echo '## write_unbound_config finished'
}

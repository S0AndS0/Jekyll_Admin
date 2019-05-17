#!/usr/bin/env bash


_DNS_CONF_DIR="${_DNS_CONF_DIR:-/etc/unbound/unbound.conf.d}"


unbound_write_ip_config(){    ## unbound_write_ip_config <ip> <url>
    local _ip_addr="${1:?No IP address provided}"
    local _url="${2:?No URL provided}"
    local _dns_conf_path="${3:?No DNS configuration path provided}"

    read -r -d '' _ip_config <<EOF
    local-data: "${_url}.      IN A    ${_ip_addr}"
    local-data-ptr: "${_ip_addr}    ${_url}."
EOF
    ## Unbound really does not take kindly to duplicate entries
    if grep -q -- "$(tail -1 <<<"${_ip_config}")" "${_dns_conf_path}" 2>/dev/null; then
        printf '# Configuration block for %s already exists in %s\n' "${_group}" "${_dns_conf_path}" >&2
        return 1
    fi
    tee -a "${_dns_conf_path}" 1>/dev/null <<<"    ${_ip_config}"

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

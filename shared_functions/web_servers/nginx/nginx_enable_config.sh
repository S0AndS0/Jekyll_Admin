#!/usr/bin/env bash


_NGINX_CONF_DIR="${_NGINX_CONF_DIR:-/etc/nginx}"


nginx_enable_config(){    ## nginx_enable_config <path>
    local _site_available_path="${1:?No sites available path provided}"
    local _site_enabled_path="${_NGINX_CONF_DIR}/sites-enabled/${_site_available_path##*/}"

    if ! [ -f "${_site_available}" ]; then
        printf 'Error - No site available at: %s\n' "${_site_available}" >&2
        return 1
    fi
    [[ -L "${_site_enabled}" ]] || ln -sv "${_site_available}" "${_site_enabled}"

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

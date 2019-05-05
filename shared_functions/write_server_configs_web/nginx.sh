#!/usr/bin/env bash
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo source ${0##*/}"; exit 1; fi

_NGINX_CONF_DIR='/etc/nginx'

## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__SUB_DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__G_PARENT__="$(dirname "${__SUB_DIR__}")"


## Provides:    remove_from_to <search-start> <search-end> <file-path>
source "${__G_PARENT__}/clobber_config.sh"


remove_nginx_config(){    ## remove_nginx_config user:group repo-name tld clobber
    _user_group="${1:?No user:domain provided}"
    _user="${_user_group%%:*}"
    _group="${_user_group##*:}"
    _group="${_group:-(groups ${_user} | awk '{print $3}')}"
    _repo="${2:?No repository name provided}"
    _tld="${3:-lan}"
    _clobber="${4:-no}"
    _sites_enabled_path="${_NGINX_CONF_DIR}/sites-enabled/${_user,,}.${_group}.${_tld}"
    _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_group}.${_tld}"
    case "${_clobber,,}" in
        'disable')
            if [ -L "${_sites_enabled_path}" ]; then
                rm -v "${_sites_enabled_path}"
            else
                printf 'No symbolic link to remove at: %s\n' "${_sites_enabled_path}"
            fi
        ;;
        'remove')
            if [ -f "${_sites_available_path}" ]; then
                if [[ "${_user,,}" == "${_repo,,}" ]]; then
                    _match_location="/"
                    _www_path="${_home}/www/${_user,,}"
                    sed -i "/${_www_path//\//\\/}/ s@^@#@" "${_sites_available_path}"
                else
                    _match_location="/${_repo}/"
                    _start_regex="location[\t ]${_match_location}[\t ]{([\t ]|$)"
                    _end_regex="}$"
                    remove_from_to "${_start_regex}" "${_end_regex}" "${_sites_available_path}"
                fi
            else
                printf 'No configuration file to remove at: %s\n' "${_sites_available_path}"
            fi
        ;;
        'delete')
            [[ -L "${_sites_enabled_path}" ]] && rm -v "${_sites_enabled_path}"
            [[ -f "${_sites_available_path}" ]] && rm -v "${_sites_available_path}"
        ;;
    esac
    printf '## %s finished\n' "${FUNCNAME[0]}"
}


write_nginx_config_direct(){    ## write_nginx_config_direct user repo-name group tld interface clobber
    _user_group="${1:?No user:domain provided}"
    _user="${_user_group%%:*}"
    _group="${_user_group##*:}"
    _group="${_group:-(groups ${_user} | awk '{print $3}')}"
    _repo="${2:?No repository name provided}"
    _tld="${3:-lan}"
    _interface="${4:-$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)}"
    _clobber="${5:-no}"

    _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    _server_name="${_user,,}.${_group}.${_tld} www.${_user,,}.${_group}.${_tld}"
    _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_group}.${_tld}"

    if [[ "${_user,,}" == "${_repo,,}" ]]; then
        _www_dir="${_home}/www/${_user}"
    else
        _www_dir="${_home}/www/${_repo}"
    fi
    if ! [ -d "${_www_dir}" ]; then
        printf 'Try "ssh %s@host-or-ip jekyll-build %s" first\n' "${_user}" "${_repo}" >&2
        return 1
    fi

    if [ -f "${_sites_available_path}" ]; then
        case "${_clober,,}" in
            'yes')
                printf 'NOTICE - Nginx sites-available config already exists, clobber set to %s\n' "${_clobber,,}"
            ;;
            *)
                printf 'Error - Nginx sites-available config already exists, clobber set to %s\n' "${_clobber,,}" >&2
                return 1
            ;;
        esac
    fi

    case "${_interface,,}" in
        'all')
            lsmod | grep -q -- 'ipv4' && _listen_ipv4='listen 0.0.0.0'
            lsmod | grep -q -- 'ipv6' && _listen_ipv6='listen [::]'
        ;;
        *)
            _ipv4="$(ip -4 addr show ${_interface} | awk '/inet /{gsub("/"," "); print $2}' | head -1)"
            _ipv6="$(ip -6 addr show ${_interface} | awk '/inet6 /{gsub("/"," "); print $2}' | head -1)"
            if [[ -z "${_ipv4}" ]] && [[ -z "${_ipv6}" ]]; then
                printf 'Error - cannot find IP address for %s\n' "${_interface}" >&2
                return 1
            fi
            [[ -n "${_ipv4}" ]] && _listen_ipv4="listen ${_ipv4}"
            [[ -n "${_ipv6}" ]] && _listen_ipv6="listen [${_ipv6}]"
        ;;
    esac

    if [ -f "${_sites_available_path}" ]; then
        _conf="$(<"${_sites_available_path}")"
        _header="${_conf%\}*}"
    else
        read -r -d '' _header <<EOF
server {
    location ~ /.git/ { deny all; }
    ## Above should prevent general public from exploring repository files if
    ##  Jekyll was told to build within the same directory as project source
    ${_listen_ipv4:-# listen 0.0.0.0}:80;
    ${_listen_ipv6:-# listen \[::\]}:80;
    server_name ${_server_name};
    index index.html index.htm;
EOF
    fi

    if [[ "${_user,,}" != "${_repo,,}" ]]; then
        _match_location="/${_repo}/"
        read -r -d '' _location <<EOF
    location ${_match_location} {
        root "${_www_dir%/*}";
        try_files \$uri \$uri/ =404;
                error_page 404 /${_repo}/404.html;
    }
EOF
        ## Search for pre-existing configuration for repository
        if [ -f "${_sites_available_path}" ] && grep -q -- "${_match_location}" "${_sites_available_path}"; then
            printf 'Location config for %s already exists within %s\n' "${_repo}" "${_sites_available_path}"
            exit 1
        fi
        read -r -d '' _new_conf <<EOF
${_header}
    ${_location}
}
## Notice - everything beyond above line is subject to auto-removal
EOF
    else
        _www_path="${_home}/www/${_user}"
        ## Search for pre-existing configuration for repository
        if [ -f "${_sites_available_path}" ] && grep -q -- "${_www_path}" "${_sites_available_path}"; then
            printf 'Location config for %s already exists within %s\n' "${_repo}" "${_sites_available_path}"
            return 1
        fi
        read -r -d '' _new_conf <<EOF
${_header}
    root "${_www_path}";
        error_page 404 /404.html;
}
## Notice - everything beyond above line is subject to auto-removal
EOF
    fi
    [[ -n "${_new_conf}" ]] && tee "${_sites_available_path}" 1>/dev/null <<<"${_new_conf}"
    printf '## %s finished\n' "${FUNCNAME[0]}"
}


nginx_enable_config(){    ## nginx_enable_config user
    _user="${1:?No user name provided}"
    _site_available="$(find ${_NGINX_CONF_DIR}/sites-available -type f | grep -i -- "${_user}" | head -1)"
    _site_enabled="${_NGINX_CONF_DIR}/sites-enabled/${_site_available##*/}"
    if ! [ -f "${_site_available}" ]; then
        printf 'Error - No site available at: %s\n' "${_site_available}" >&2
        return 1
    fi
    [[ -L "${_site_enabled}" ]] || ln -sv "${_site_available}" "${_site_enabled}"
    printf '## %s finished\n' "${FUNCNAME[0]}"
}

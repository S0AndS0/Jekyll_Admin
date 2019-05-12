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


## Provides:  remove_from_to <search-start> <search-end> <file-path>
source "${__GGG_PARENT__}/shared_functions/remove_from_to.sh"


nginx_remove_config(){    ## nginx_remove_config <user>:group <repo> tld clobber
    local _user_group="${1:?No user:domain provided}"
    local _user="${_user_group%%:*}"
    local _group="${_user_group##*:}"
    _group="${_group:-$(groups ${_user} | awk '{print $3}')}"
    local _repo="${2:?No repository name provided}"
    local _tld="${3:-lan}"
    local _clobber="${4:-no}"
    local _sites_enabled_path="${_NGINX_CONF_DIR}/sites-enabled/${_user,,}.${_group}.${_tld}"
    local _sites_available_path="${_NGINX_CONF_DIR}/sites-available/${_user,,}.${_group}.${_tld}"

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

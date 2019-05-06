#!/usr/bin/env bash
## Exit if not running with root/level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo ${0##*/} ${@:---help}"; exit 1; fi


#
#    Set defaults for script variables; these maybe overwritten at run-time
#
_user='jek'
_group='devs'
_server='nginx'
_repo="${_user}"
_tld='lan'
_interface="$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)"
_clobber='no'


#
#    Set script variables that should not be modified
#
_LESS_OPTS='--quit-at-eof --quit-if-one-screen --chop-long-lines --RAW-CONTROL-CHARS --LONG-PROMPT'
## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"
__PATH__="${__DIR__}/${__NAME__}"
__AUTHOR__='S0AndS0'
__DESCRIPTION__='Writes Web Server configurations for Jekyll and/or Git client projects'


#
#    Source useful functions
#
## Provides:    'failure'
source "${__DIR__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR

## Provides:  'argument_parser <ref_to_allowed_args> <ref_to_user_supplied_args>'
source "${__DIR__}/shared_functions/arg_parser.sh"

## Provides:    'write_nginx_config_direct <user> <repo> group tld interface clobber'
##        'remove_nginx_config <user>:group|domain <repo> <tld> <clobber>'
##        'nginx_enable_config <user>'
source "${__DIR__}/shared_functions/write_server_configs_web/nginx.sh"

## Provides: '__license__ <description> <author>'
source "${__DIR__}/shared_functions/license.sh"


usage(){
    local -n _parsed_argument_list="${1}"
    cat <<EOF
${__DESCRIPTION__}

# Options
  -u    --user=${_user}
Name of user to look under their home for '~/www' directory, for Jekyll
 built static files built from ${_repo} for serving via ${_server}

  -r    --repo=${_repo}

  -g    -d    --domain    --group=${_group}
Domain/group name that user will become a sub-domain of.

  -s    --server=${_server}
Server type, eg 'apache2' or 'nginx' to write and link configuration files
 for. Try '${__NAME__} examples'

  -i    --interface=${_interface}
Interface that web-server is listening on. IPv4 & IPv6 listening addresses
 will automatically be parsed and added to the ${_server} configuration or
 config. directory if available.

  -t    --tld    --top-level-domain=${_tld}
Top level domain name, eg 'local', 'io' or 'com', etc. Note if left empty or
 unset, and if repo contains a period eg 'jekyll-template.local' then the
 last word is parsed out as the TLD.

  -c    --clobber=${_clobber}
If 'yes' then pre-existing server configuration files will be appended to.
 If 'remove' then pre-existing location configuration will be removed for
 given repository.
 If 'disable' then the symbolic link pointing to given user web server
 configurations will be removed, disabling all sites for that user.
 If 'delete' then both operations for remove and disable will be preformed
 Default: 'no'

  -l    --license
Shows script or project license then exits

  -h    --help
Shows values set for above options, print usage, then exits
EOF

    if [ "${#_parsed_argument_list[@]}" -gt '0' ]; then
        cat <<EOF

Parsed command arguments

$(for _arg in "${_parsed_argument_list[@]}"; do printf '    %s\n' "${_arg}"; done)
EOF
    fi
}


#
#    Read & save recognized arguments to variables
#
_args=("${@:?# No arguments provided try: ${__NAME__} help}")
_valid_args=('--help|-h|help:bool'
             '--license|-l|license:bool'
             '--server|-s:posix'
             '--interface|-i:posix'
             '--user|-u:posix'
             '--group|-g|--domain|-d:posix'
             '--tld|-t|--top-level-domain:alpha_numeric'
             '--repo|-r:posix'
             '--clobber|-c:alpha_numeric')
argument_parser '_args' '_valid_args'
_exit_status="$?"

if ((_help)) || ((_exit_status)); then
    usage '_assigned_args' | less ${_LESS_OPTS}
    exit ${_exit_status:-0}
elif ((_license)); then
    __license__ "${__DESCRIPTION__}" "${__AUTHOR__}"
    exit ${_exit_status:-0}
fi


#
#       Do stuff with assigned functions & variables
#
case "${_server,,}" in
    'nginx')
        case "${_clobber,,}" in
            'remove'|'disable'|'delete')
                remove_nginx_config "${_user}:${_group}" "${_repo}" "${_tld}" "${_clobber}"
                systemctl restart nginx.service
            ;;
            *)
                write_nginx_config_direct "${_user}:${_group}" "${_repo}" "${_tld}" "${_interface}" "${_clobber}"
                nginx_enable_config "${_user}"
                systemctl restart nginx.service
            ;;
        esac
    ;;
    *)
        echo "${__NAME__} not currently coded to setup ${_server}"
    ;;
esac

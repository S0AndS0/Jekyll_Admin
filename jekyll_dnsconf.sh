#!/usr/bin/env bash
## Exit if not running with root/level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo ${0##*/} ${@:---help}"; exit 1; fi
set -eE -o functrace


#
#	Set defaults for script variables; these maybe overwritten at run-time
#
_server='unbound'
_user='jek'
_group='devs'
_tld='lan'
_interface="$(ls -1 /sys/class/net/ | grep -v 'lo' | head -1)"
_clobber='no'


#
#	Set script variables that should not be modified
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
__DESCRIPTION__='Writes DNS configurations for Jekyll and/or Git clients'


#
#       Source useful functions
#
## Provides: 'falure' <line-number> <command> exit-code
##           'examples_dns' args
source "${__DIR__}/shared_functions/failure.sh"
trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR

## Provides:	'write_unbound_config <user> <repo> tld interface clobber'
##						'remove_unbound_config' <group> <tld> <interface> <clobber>
source "${__DIR__}/shared_functions/write_unbound_config.sh"

## Provides:  'argument_parser <ref_to_allowed_args> <ref_to_user_supplied_args>'
source "${__DIR__}/shared_functions/arg_parser.sh"

## Provides: '__license__ <description> <author>'
source "${__DIR__}/shared_functions/license.sh"


usage(){
	local -n _args="${1}"
  cat <<EOF
#
# Note: this script is only needed when a new user is added.
#
## Options
# -s	--server=${_server}
# Server type, eg 'apache2' or 'nginx' to write and link configuration files
#  for. Try '${__NAME__} examples'
#
# -u	--user=${_user}
# Name of user that will become a sub domain of ${_group}
#  ${_user}.${_group}.${_tld}
#  to be precise.
#
# -g -d	--group --domain=${_group}
# The domain/group name that git client usernames are used as sub-domains for
#  serving via web-server.
#
# Note if both user and group match then the url configured will be
#  ${_group}.${_tld}
#
# -i	--interface=${_interface}
# Interface that domain name server is listening on. IPv4 & IPv6 listening
#  addresses will automatically be parsed and added to the ${_server}
#  configuration or config. directory if available.
# Note interface may also be set to 'all' if clobber is set to 'remove' to force
#  removal of all configuration blocks that match specific urls, eg
#  ${_user}.${_group}.${_tld} or ${_group}.${_tld}
#
# -t	--tld --top-level-domain=${_tld}
#	Top level domain name, eg 'local', 'io' or 'com', etc. Note if left empty or
#  unset, and if repo contains a period eg 'jekyll-template.local' then the
#  last word is parsed out as the TLD.
#
# -c	--clobber=${_clobber}
# If 'yes' then pre-existing server configuration group file will be appended
#  with new configuration blocks.
#  If 'remove' then pre-existing server configuration blocks will be removed
#  from configuration file.
#  If 'delete' then server configuration group file will be removed.
#  Default is 'no'
#
# -l --license
# Shows script or project license then exits
#
# -h	--help
# Shows values set for above options, print usage, then exits
EOF
	if [ "${#_args[@]}" -gt '0' ]; then
		cat <<-EOF
		#
		# Parsed command arguments
		#
		$(for _arg in "${_args[@]}"; do printf '#\t%s\n' "${_arg}"; done)
		EOF
	fi
}


#
#	Read & save recognized arguments to variables
#
_args=("${@:?# No arguments provided try: ${__NAME__} help}")
_valid_args=('--help|-h|help:bool'
             '--license|-l|license:bool'
             '--server|-s:posix'
						 '--user|-u:posix'
						 '--group|-g|--domain|-d:posix'
						 '--tld|-t|--top-level-domain:alpha_numeric'
						 '--interface|-i:posix'
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
	'unbound')
		case "${_clobber,,}" in
			'remove'|'delete')
				remove_unbound_config "${_user}:${_group}" "${_tld}" "${_interface}" "${_clobber}"
				# systemctl restart unbound.service
			;;
			*)
				write_unbound_config "${_user}:${_group}" "${_tld}" "${_interface}" "${_clobber}"
				# systemctl restart unbound.service
			;;
		esac
	;;
	*)
		echo "${__NAME__} not currently coded to setup ${_server}"
	;;
esac
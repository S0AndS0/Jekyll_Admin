#!/usr/bin/env bash
## Exit if not running with root/sudo level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo ${0##*/} ${1:-linux} ${2:-install}"; exit 1; fi

_DEBIAN_DEPENDS_LIST='git ruby-full nodejs gawk'

apt_get(){
	_args="${@}"
	_list="${_args//${1} /}"
	case "${1,,}" in
		'install') apt-get update && apt-get install ${_list} ;;
		*)         apt-get remove ${_list} ;;
	esac
	echo '## apt_get finished'
}

detect_install_method_linux(){
	_id_like="$(awk -F'=' '/^ID_LIKE=/ {print tolower($2)}' /etc/*-release 2>/dev/null)"
	_top_likeness="$(sort -u <<<"${_id_like}" | head -1)"
	case "${_top_likeness}" in
		'debian'|'ubuntu')
			apt_get "${1:-uninstall}" "${_DEBIAN_DEPENDS_LIST}"
		;;
		## Add more distribution specific function calls here
		*)
			printf 'Error - dependencies_install.sh not currently coded for %s\n' "${_top_likeness}"
			return 1
		;;
	esac
	echo '## detect_install_method_linux finished'
}


if ! [ -z "${1}" ]; then
	_INSTALL_OR_UNINSTALL="${2:-uninstall}"
	case "${1,,}" in
		'linux')
			detect_install_method_linux "${_INSTALL_OR_UNINSTALL}"
		;;
		## Add more OS specific function calls here
		*)
			printf 'Error - dependencies_install.sh not currently coded for %s\n' "${1:-unnamed}"
			return 1
		;;
	esac
fi

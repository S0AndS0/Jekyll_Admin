#!/usr/bin/env bash

## Exit if not running with root/level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo source ${0##*/}"; exit 1; fi

modify_etc_shells(){
	_login_shell="${1:?No login shell path provided}"
	_git_shell="$(which git-shell)"
	_firejail_shell="$(which firejail)"
	## Add firejail to available shells if not already available
	if [ -e "${_firejail_shell}" ] && [[ "${_firejail_shell}" == "${_login_shell}" ]]; then
		if ! grep -q -- "${_firejail_shell}" '/etc/shells'; then
			printf 'Adding %s to /etc/shells\n' "${_firejail_shell}"
			tee -a /etc/shells >/dev/null <<<"${_firejail_shell}"
		fi
	## Or add 'git-shell' to available shells if not already available
	elif [ -e "${_git_shell}" ] && [[ "${_git_shell}" == "${_login_shell}" ]]; then
		if ! grep -q -- "${_git_shell}" '/etc/shells'; then
			printf 'Adding %s to /etc/shells\n' "${_git_shell}"
			tee -a /etc/shells >/dev/null <<<"${_git_shell}"
		fi
	else
		printf 'modify_etc_shells not yet coded to add shell %s to /etc/shells\n' "${_login_shell}"
		return 1
	fi
	echo '## modify_etc_shells finished'
}

add_ssh_authorized_keys(){
	_user="${1:?No user name provided}"
	_new_ssh_keys="${2:?No authorized keys provided}"
	_home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
	_authorized_keys="${_home}/.ssh/authorized_keys"
	if [ -f "${_authorized_keys}" ]; then
		printf 'SSH authorized_keys file already exists for %s\n' "${_user}"
		return 1
	fi
	_group="$(groups ${_user} | awk '{print $3}')"
	mkdir -vp "${_home}/.ssh" || return 1
	if [ -f "${_new_ssh_keys}" ]; then
		tee -a "${_authorized_keys}" 1>/dev/null <<<"$(<"${_new_ssh_keys}")"
	else
		case "${_new_ssh_keys}" in
			*'ssh-rsa'*|*'ssh-dsa'*|*'ssh-ecdsa'*|*'ssh-ed25519'*)
				tee -a "${_authorized_keys}" 1>/dev/null <<<"$(printf '%s\n' "${_new_ssh_keys}")"
			;;
			*)
				echo 'String did not match known authorized_keys format'
				return 1
			;;
		esac
	fi
	## Set correct permissions and ownership for directory and authorized_keys file
	chmod -v 600 "${_home}/.ssh/authorized_keys"
	chmod -v 700 "${_home}/.ssh"
	chown -vR "${_user}":"${_group}" "${_home}/.ssh"
	echo '## add_ssh_authorized_keys finished'
}

add_jekyll_user(){
	_user_group="${1:?No user:group name provided}"
	_user="${_user_group%%[ :]*}"
	_group="$(awk -F'[ :]' '{print $2}' <<<"${_user_group}")"
	# _group=${_user_group##*[ :]};
	## Note, above will throw-off some syntax highlighters if quoted
	##  Atom so far, and if there is not a semicolon after... hence
	##  why for the awk and bellow re-assignment.
	_group="${_group:-$_user}"
	_shell="${2:?No shell path provided}"
	_additional_groups="${3}"
	_base_home_dir="${4:-/srv}"
	_home="${_base_home_dir}/${_user,,}"
	if grep -qiE -- "^${_user}:" '/etc/passwd'; then
		printf 'User %s already exists\n' "${_user}"
		return 1
	else
		if ! getent group "${_group}" 1>/dev/null; then
			printf 'Adding group %s\n' "${_group}"
			groupadd ${_group}
		fi
		## Relaxed regex from defaults to allow capitalization in usernames
		NAME_REGEX='^[a-zA-Z][-a-zA-Z0-9]*$' adduser\
		 --force-badname\
		 --system\
		 --disabled-password\
		 --gecos ''\
		 --shell "${_shell}"\
		 --home "${_home,,}"\
		 --ingroup ${_group}\
		 ${_user}

		if [ -n "${_additional_groups}" ]; then
			## Add any additional groups that do not exist yet
			for _additional_group in ${_additional_groups//,/ }; do
				if getent 'group' "${_additional_group}" 1>/dev/null; then continue; fi
				printf 'Adding group %s\n' "${_additional_group}"
				groupadd "${_additional_group}"
			done
			## Add list of additional groups to user
			usermod -a -G "${_additional_groups}" "${_user}"
		fi
	fi
	echo '## add_jekyll_user finished'
}

add_firejail_user(){
	_user="${1:?No user name provided}"
	_shell="${2:-$(which git-shell)}"
	_firejail_conf_dir="$(which firejail | sed 's/bin/etc/')"

	[[ -d "${_firejail_conf_dir}" ]]                || return 1
	[[ -f "${_firejail_conf_dir}/login.users" ]]    || return 1
	[[ -f "${_firejail_conf_dir}/firejail.users" ]] || return 1
	[[ -e "${_git_shell}" ]]                        || return 1

	if ! grep -q -- "${_user}" "${_firejail_conf_dir}/firejail.users"; then
		printf 'Appending "%s" to: %s/firejail.users\n' "${_user}" "${_firejail_conf_dir}"
		tee -a "${_firejail_conf_dir}/firejail.users" 1>/dev/null <<<"${_user}"
	fi
	if ! grep -q -- "${_user}" "${_firejail_conf_dir}/login.users"; then
		printf 'Appending "%s:--shell=%s" to: %s/login.users\n' "${_user}" "${_shell}" "${_firejail_conf_dir}"
		tee -a "${_firejail_conf_dir}/login.users" 1>/dev/null <<<"${_user}:--shell=${_shell}"
	fi
	echo '## add_firejail_user finished'
}

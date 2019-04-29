#!/usr/bin/env bash

clobber_ownership(){ ## clobber_ownership user:group path
  _user_group="${1:?No user:group provided}"
  _user="${_user_group%%:*}"
  _group="${_user_group##*:}"
  _group="${_group:-$(groups ${_user} | awk '{print $3}')}"
  _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
  _sub_dir="${2:-git}"
  _path="${_home}/${_sub_dir}"
  if ! [ -d "${_path}" ] && ! [ -f "${_path}" ]; then
    printf 'No directory or file found at: %s\n' "${_path}"
    exit 1
  fi
  _current_user_group="$(stat --format='%U:%G' "${_path}" | head -1)"
  _current_user="${_current_user_group%%:*}"
  _current_group="${_current_user_group##*:}"
  ## Update ownership as needed
  if [[ "${_user}" != "${_current_user}" ]] && [[ "${_group}" != "${_current_group}" ]]; then
    find "${_path}" -user ${_current_user} -exec chown -h ${_user} {} \;
    find "${_path}" -group ${_current_group} -exec chgrp -h ${_group} {} \;
  elif [[ "${_user}" != "${_current_owner_user}" ]]; then
    find "${_path}" -user ${_current_user} -exec chown -h ${_user} {} \;
  elif [[ "${_group}" != "${_current_owner_group}" ]]; then
    find "${_path}" -group ${_current_group} -exec chgrp -h ${_group} {} \;
  else
    printf 'Going to have to re-think changing ownership of: %s\n' "${_path}"
    exit 1
  fi
}

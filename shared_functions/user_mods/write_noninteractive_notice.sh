#!/usr/bin/env bash


write_noninteractive_notice(){    ## write_noninteractive_notice <user>
    local _user="${1:?No user name provided}"

    local _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    local _script_path="git-shell-commands/no-interactive-login"

    su --shell "$(which bash)" --login "${_user}" <<EOF
mkdir -vp "\${HOME}/git-shell-commands"
touch "\${HOME}/${_script_path}"
EOF

    tee "${_home}/${_script_path}" 1>/dev/null <<'EOF'
#!/usr/bin/env bash
__f_line__="$(for ((i=0; i<9; i++)); do printf '_'; done; printf '\n')"

printf '\n%s\n' "${__f_line__}"
printf 'Hi %s, you have successfully authenticated!\n' "${USER}"
echo 'However, there is not an interactive shell here.'
printf '%s\n' "${__f_line__}"

exit 128
EOF
    su --shell "$(which bash)" --command "chmod u+x '\${HOME}/${_script_path}'" --login "${_user}"

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

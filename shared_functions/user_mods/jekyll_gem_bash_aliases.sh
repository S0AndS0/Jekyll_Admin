#!/usr/bin/env bash


jekyll_gem_bash_aliases(){    ## jekyll_gem_bash_aliases <user>
    local _user="${1:?No user name provided}"
    local _home="$(awk -F':' -v _user="${_user}" '$0 ~ "^" _user ":" {print $6}' /etc/passwd)"
    if [ -f "${_home}/.bash_aliases" ]; then
        printf '%s/.bash_aliases already exists\n' "${_home}" >&2
        return 1
    fi

    ## Save new user path variable for Ruby executables
    su --shell "$(which bash)" --command 'touch ${HOME}/.bash_aliases' --login "${_user}"
    tee -a "${_home}/.bash_aliases" 1>/dev/null <<'EOF'
## Ruby exports for user level gem & bundle installs
export GEM_HOME="${HOME}/.gem"
export PATH="${GEM_HOME}/bin:${PATH}"
EOF
    su --shell "$(which bash)" --command 'chmod u+x ${HOME}/.bash_aliases' --login "${_user}"

    printf '## %s finished\n' "${FUNCNAME[0]}"
}

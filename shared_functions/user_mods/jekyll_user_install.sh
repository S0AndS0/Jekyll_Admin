#!/usr/bin/env bash


jekyll_user_install(){    ## jekyll_user_install <user>
    local _user="${1:?No user name provided}"
    ## Install bundler & jekyll under new user home directory
    ##  Note one must source .bash_aliases upon every gem interactive login because '--system'
    ##  option was used during adduser command, so there be no fancy .bashrc file by default
    ##  to source files for users... but this account is not destined for regular interactions
    su --shell $(which bash) --login ${_user} <<'EOF'
source "${HOME}/.bash_aliases"

float_ge(){
    local _f1="${1:?No first float}"
    local _f2="${2:?No second float}"
    awk -v _n1="${_f1}" -v _n2="${_f2}" 'BEGIN {print (_n1 >= _n2)}'
    return "${?}"
}

mkdir -vp "${HOME}"/{git,www}

## Initialize Jekyll repo for user account
_old_PWD="${PWD}"
mkdir -vp "${HOME}/git/${USER}"
cd "${HOME}/git/${USER}"
git init .
git checkout -b gh-pages

_ruby_version="$(ruby --version)"
_ruby_version="$(awk '{print $2}' <<<"${_ruby_version%.*}")"
_ruby_version_main="${_ruby_version%.*}"
_ruby_version_sub="${_ruby_version#*.}"
if (($(float_ge "${_ruby_version}" '2.1'))); then
    gem install bundler -v '< 2'
    gem install jekyll -v '3.8.5'

    bundle init
    bundle install --path "${HOME}/.bundle/install"
    bundle add jekyll-github-metadata github-pages

    bundle exec jekyll new --force --skip-bundle "${HOME}/git/${USER}"
    bundle install
else
    echo 'Please see to installing Ruby verion >= 2.1'
    echo 'Hints may be found at, https://jekyllrb.com/docs/installation/'
fi

git config receive.denyCurrentBranch updateInstead

cat >> "${HOME}/git/${USER}/.gitignore" <<EOL
# Ignore files and folders regenerated by Bundler
Bundler
vendor
.bundle
EOL

git add --all
git -c user.name="${USER}" -c user.email="${USER}@${HOSTNAME}" commit -m "Added files from Bundler & Jekyll to git tracking"
cd "${_old_PWD}"
EOF
    local _exit_status="${?}"

    printf '## %s finished\n' "${FUNCNAME[0]}"
    return "${_exit_status}"
}

#!/usr/bin/env bash
## Exit if not root or sudo level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo ${0##*/} ${@:---help}"; exit 1; fi

_AUTHOR_BRANCH='master'
_LOCAL_BRANCH='local'

#
#    Set script variables that should not be modified
#
## True path to script
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"
__REPO_DIR__="${__DIR__%/*}"
__ORIG_PWD__="${PWD}"

#
#    Source useful functions
#
## Provided     'failure'
set -eE -o functrace
trap 'failure ${LINENO} "${BASH_COMMAND}"' ERR

usage(){
    cat <<EOF
## Options
# update    |    git-update
#  Runs git commands required to update source while allowing users to revert
#  any overwritten local changes.
#
# install |    git-checkout
#  Runs git commands required to checkout local git branch after install and
#  git merge changes from the master branch.
EOF
}

git_pull_update(){
    _git_remotes="$(git remote -v)"
    if ! [ "${#_git_remotes}" -gt '0' ]; then
        echo 'No remotes configured to git pull from!'
        return 1
    fi
    cd "${__REPO_DIR__}"
    _orig_branch="$(git branch --list | awk '/\*/{print $2}')"
    if grep -qE -- '^Untracked files|^Changes to be committed|^Changes not staged' <<<"$(git status)"; then
        git add --all
        _msg="${__NAME__} added files to git tracking customizations prior to make update"
        git commit -m "${_msg}"
    fi
    if [[ "${_orig_branch}" != "${_AUTHOR_BRANCH}" ]]; then
        git checkout "${_AUTHOR_BRANCH}"
    fi
    git pull
    cd "${__ORIG_PWD__}"
}


git_checkout_install(){
    cd "${__REPO_DIR__}"
    _branches="$(git branch --list)"
    _orig_branch="$(awk '/\*/{print $2}' <<<"${_branches}")"
    _local_branch="$(awk -v _b="${_LOCAL_BRANCH}" '$0 ~ _b {gsub("[* ]",""); print}' <<<"${_branches}" | head -1)"
    if [ -n "${_local_branch}" ]; then
        git checkout "${_local_branch}"
    else
        git checkout -b "${_LOCAL_BRANCH}"
    fi
    git config core.fileMode false
    git merge --strategy-option theirs --squash ${_AUTHOR_BRANCH}
    _msg="${__NAME__} merged changes from ${_AUTHOR_BRANCH}"
    git commit -m "${_msg}"
    cd "${__ORIG_PWD__}"
}


check_git_configs(){
    if [ -z "$(git config user.name)" ]; then
      printf '# git config --local user.name "%s"\n' "${USER}"
      git config --local user.name "${USER}"
    fi

    if [ -z "$(git config user.email)" ]; then
      printf '# git config --local user.email "%s@%s.lan"\n' "${USER}" "${HOSTNAME}"
      git config --local user.email "${USER}@${HOSTNAME}.lan"
    fi
}


case "${1,,}" in
    'update'|'git-update')
        check_git_configs
        git_pull_update || echo 'Ignore if above states "No remotes configured..."'
    ;;
    'install'|'git-checkout')
        check_git_configs
        git_checkout_install
    ;;
    *)
        usage
        exit 1
    ;;
esac
exit "${?}"

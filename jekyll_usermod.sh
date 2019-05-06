#!/usr/bin/env bash
## Exit if not running with root/level permissions
if [[ "${EUID}" != '0' ]]; then echo "Try: sudo ${0##*/} ${@:---help}"; exit 1; fi


#
#    Set defaults for script variables; these maybe overwritten at run-time
#
_ssh_auth_keys=''
## Web server group name, 'www-data' for Apache2, Nginx, and many other web servers
_www_group="www-data"
## New git/jekyll server user & group names. Note user will have read & write access
##  where as group will have read only permissions, hopefully allowing collaboration
_user='jek'
_group='devs'
## Default '/srv' to avoid cluttering up '/home' directory with non-login users
_HOME_BASE='/srv'
## Note to delete this user issue the following
#        _home="${_HOME_BASE}/${_user}"
#        deluser --remove-home jekdev
#        [[ -d "${_home}" ]] && rm -rf ${_home}
_git_shell_allowed='all'
_git_shell_copy_or_link='copy'
_clobber='no'
_git_shell="$(which git-shell)"
_LOGIN_SHELL="${_git_shell}"
## See notice in read_me.md file, TLD does not work until Firejail bugs are stomped
#_LOGIN_SHELL="$(which firejail)"
#_LOGIN_SHELL="${_LOGIN_SHELL:-$_git_shell}"


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
__DESCRIPTION__='Adds new Git/Jekyll user equiped with simple git_shell_commands'


#
#    Source useful functions
#
## Provided     'failure'
source "${__DIR__}/shared_functions/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR

## Provides:    'modify_etc_shells <login-shell>'
##        'add_ssh_authorized_keys <user> <ssh-authorized-keys>'
##        'add_firejail_user <user>'
## 'add_jekyll_user <user>:<group> <login-shell> group-one,group-two <home-parent>'
source "${__DIR__}/shared_functions/add_user.sh"

## Provides:    'jekyll_modify_user_path <user>'
##        'jekyll_user_install <user>'
source "${__DIR__}/shared_functions/jekyll_user_mods.sh"

## Provides:    'copy_or_link_paths <source> <dest> copy-or-link clobber'
##        'copy_or_link_git_shell_scripts <user> allowed-scripts copy-or-link client-pushable clobber'
source "${__DIR__}/shared_functions/copy_or_link_git_shell_scripts.sh"

## Provides:  'argument_parser <ref_to_allowed_args> <ref_to_user_supplied_args>'
source "${__DIR__}/shared_functions/arg_parser.sh"

## Provides: '__license__ <description> <author>'
source "${__DIR__}/shared_functions/license.sh"


usage(){
    local -n _parsed_argument_list="${1}"
    cat <<EOF
${__DESCRIPTION__}

# Options

  -u    --user="${_user}"
Name of user to create and install Jekyll  under. Must be a new user name,
 account  will be locked, and home directory will be under ${_HOME_BASE}

  -g    --group="${_group}"
Name of group that may pull or clone but not push. This maybe useful for
 collaborative servers with multiple Jekyll/Git users sharing code within
 groups; try '--examples' option.

  -w    --www-group="${_www_group}"
Name of group that web server uses to serve content. Default for Apache2,
 Nginx and many others is "www-data"

  --ssh-auth-keys="${_ssh_auth_keys}"
Path to authorized_keys file to copy over to ${_HOME_BASE}/${_user}/.ssh
 directory. Note if using redirection, eg...

    --ssh-auth-keys=\\""\$(<~/.ssh/pub.key)\\""
    --ssh-auth-keys \\"'\$(<~/.ssh/pub.key)'\\"

 ... then double quoting is required!

  --git-shell-allowed="${_git_shell_allowed}"
Maybe list of specific scripts under 'git_shell_commands/' directory, 'none',
 or 'all' to select what scripts are linked or copied over to ${_user}

  --git-shell-copy-or-link="${_git_shell_copy_or_link}"
Maybe 'copy', 'pushable' or 'link' to signify weather or not to link or copy
 scripts from 'git_shell_commands/' directory to

  -c    --clobber="${_clobber}"
Maybe 'yes' or 'no' and determines if specific files are overwritten or if
 errors are returned because of multiple runs of ${__NAME__}

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
             '--user|-u:posix'
             '--group|-g:posix'
             '--www-group|-w:posix'
             '--ssh-auth-keys:path'
             '--git-shell-allowed:list'
             '--git-shell-copy-or-link:alpha_numeric'
             '--clobber|-c:alpha_numeric')
argument_parser '_args' '_valid_args'
_exit_status="$?"

if ((_help)) || ((_exit_status)); then
    usage '_assigned_args' | less ${_LESS_OPTS}
    exit ${_exit_status:-0}
elif ((_license)); then
    __license__ "${__DESCRIPTION__}" "${__AUTHOR__}"
    exit ${_exit_status:-0}
elif [[ -z "${_ssh_auth_keys}" ]]; then
    usage '_assigned_args' | less ${_LESS_OPTS}
    exit ${_exit_status:-1}
fi


#
#    Do stuff with assigned functions & variables
#
modify_etc_shells "${_LOGIN_SHELL}"
add_jekyll_user "${_user}:${_group}" "${_LOGIN_SHELL}" "${_www_group}" "${_HOME_BASE}"
#add_firejail_user "${_user}"
add_ssh_authorized_keys "${_user}" "${_ssh_auth_keys}"
jekyll_modify_user_path "${_user}"
echo "... the following may take awhile..."
jekyll_user_install "${_user}"
copy_or_link_git_shell_commands "${_user}" "${_git_shell_allowed}" "${_git_shell_copy_or_link}" "${_clobber}"


#
#    Inspiration &/or information sources
#
## https://askubuntu.com/questions/94060/run-adduser-non-interactively
## https://guides.rubygems.org/faqs/
## https://jekyllrb.com/docs/installation/ubuntu/
## https://stackoverflow.com/questions/21279481/git-shell-new-repositories
## https://stackoverflow.com/questions/3740152/how-do-i-set-chmod-for-a-folder-and-all-of-its-subfolders-and-files?rq=1
## https://jekyllrb.com/tutorials/using-jekyll-with-bundler/
## https://stackoverflow.com/questions/3221859/cannot-push-into-git-repository
## man less
## https://stackoverflow.com/questions/39384283/how-to-match-a-pattern-given-in-a-variable-in-awk
## https://unix.stackexchange.com/questions/257604/awk-combine-variable-and-regular-expression-in-pattern-match
## https://superuser.com/questions/468727/how-to-get-the-ipv6-ip-address-of-linux-machine
## https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation
## https://gist.github.com/tvlooy/cbfbdb111a4ebad8b93e
## https://www.cyberciti.biz/faq/check-for-ipv6-support-in-linux-kernel/
## https://unix.stackexchange.com/questions/145348/short-simple-command-to-create-a-group-if-it-doesnt-already-exist
## man adduser.conf NAME_REGEX
## https://unix.stackexchange.com/questions/462156/how-do-i-find-the-line-number-in-bash-when-an-error-occured
## https://stackoverflow.com/questions/29081531/shell-script-print-line-number-when-it-errors-out
## https://stackoverflow.com/questions/22058041/commit-without-setting-user-email-and-user-name
## https://stackoverflow.com/questions/3242282/how-to-configure-an-existing-git-repo-to-be-shared-by-a-unix-group
## https://stackoverflow.com/questions/2180270/check-if-current-directory-is-a-git-repository
## https://superuser.com/questions/648163/recursively-chown-all-files-that-are-owned-by-a-specific-user
## https://serverfault.com/questions/17255/top-level-domain-domain-suffix-for-private-network
## https://en.internetwache.org/dont-publicly-expose-git-or-how-we-downloaded-your-websites-sourcecode-an-analysis-of-alexas-1m-28-07-2015/
## https://stackoverflow.com/questions/962255/how-to-store-standard-error-in-a-variable-in-a-bash-script

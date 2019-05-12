[![Build Status][badge_travis_ci]][build_travis_ci] means that tests defined within the [`travis.yml`][source_travis_yml] configuration file either _passed_ or _failed_.


___


Collection of Bash scripts for Jekyll and Git server administration and interaction via `ssh` or `git` command-line tools.


> Unless otherwise stated both documentation and Bash scripts are shared under the [_`GNU AGPL version 3`_][docs_license_tldr] license by default, a full copy of which is available under [_`master:LICENSE`_][license]


[_`Documentation`_][docs_home] is hosted by GitHub Pages, the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][branch_gh_pages] `branch`. [_`Installation`_][docs_install], and [_`Update`_][docs_update] instructions are currently featured along with usage examples for [_`Administrators`_][docs_collection_administration] and [_`Git`/`Jekyll`_][docs_collection_git_shell_commands] clients.


To add features or fix issues within this project; start with making a [_`Fork`_][help_fork] of this repository, then make changes (testing if code related), and update the [`_contributers`][contributers] directory with a file about your self (and maybe a summery of changes) before issuing a [_`Pull Request`_][help_pull_request]. See the [_`Contributing`_][contributing] collection for examples of development setup and other tips.


___


## Requirements


- Ruby version >= 2.1 for; Jekyll version 3.8.5, and Bundler version 1.17.3

- Bash version >= 4 for; _`local -n _ref_one="${1}"`_ and other _fanciness_ at the shell level

- Debian based Linux or the knowhow to install `apt` dependencies via another package manager


___


## Quick start


> The following should be preformed on a private server, VPS, RPi, etc...


- 0. Install dependencies


```bash
sudo apt-get install build-essential\
                     git-core\
                     nginx\
                     ruby-full\
                     unbound\
                     zlib1g-dev
```


> Securing `nginx` and `unbound` servers is currently outside the scope of this file and documentation for this project.


- 1. Elivate to `root` level permissions and clone within a directory for source installed tools...


```bash
sudo su -
cd /usr/local/etc
git clone git@github.com:S0AndS0/Jekyll_Admin.git
cd Jekyll_Admin
```


- 2. Install or update via make


```bash
make install-dependencies
make install
## ... or
#  make update && make install
```


- 3.
    <sup>a</sup> For each group/domain run the `jekyll_dnsconf.sh` script, for each user run the `jekyll_usermod.sh` script, and for each repository of each user run the `jekyll_wwwconf.sh` script

    <sub>b</sub> Organize the list of users based off their shared group within some kind of data structure (in this case an associative array) and loop over it while utilizing project scripts to set-up things...


```bash
#!/usr/bin/env bash


declare -A _grouped_users=(
    ['admins']='Joan:Liz'
    ['devs']='Bill:Ted'
)

_key_dir="${HOME}/git_public_keys"
for _domain in "${!_grouped_users[@]}"; do
    for _user in ${_grouped_users[${_domain}]//:/ }; do
        _usermod_args=(
            '--user' "${_user}"
            '--group' "${_domain}"
            '--ssh-pub-key' "${_key_dir}/${_user,,}.pub"
        )
        case "${_domain}" in
            'admins')
                _usermod_args+=('--git-shell-copy-or-link' 'pushable')
            ;;
            *)
                if [[ "${_user,,}" != 'bill' ]]; then
                    _usermod_args+=('--git-shell-copy-or-link' 'pushable')
                fi
            ;;
        esac
        jekyll_usermod.sh "${_usermod_args[@]}"
        jekyll_wwwconf.sh --user "${_user}"\
                        --domain "${_domain}"\
                           --tld 'lan'\
                          --repo "${_user}"\
                        --server 'nginx'\
                       --clobber 'force'
    done
    if ! [ -f "/etc/unbound/unbound.conf.d/${_domain}.lan.conf" ]; then
        jekyll_dnsconf.sh --server 'unbound'\
                       --interface 'eth0'\
                          --domain "${_domain}"\
                             --tld 'lan'
    fi
done
```


> The above will allow _`git push`es_ by a user to their own `git-shell-commands` directory, except for _`Bill`_ who'll have scripts copied over but not setup with _`Git`_ tracking; for reasons.


... and perhaps write a cron job script for occasionally adding configuration blocks as repositories are built into pages...


```bash
#!/usr/bin/env bash

_home_base='/srv'

declare -A _grouped_users=(
    ['admins']='Joan:Liz'
    ['devs']='Bill:Ted'
)

_wwwconf_args_base=(
    '--clobber' 'update'
    '--interface' 'eth0'
    '--server' 'nginx'
    '--tld' 'lan'
)

for _domain in "${!_grouped_users[@]}"; do
    for _user in ${_grouped_users[${_domain}]//:/ }; do
        _www_dir="${_home_base}/${_user}/www"
        [[ -d "${_www_dir}" ]] || continue
        for _srv_dir in "${_www_dir}/"*; do
            jekyll_wwwconf.sh ${_wwwconf_args_base[*]}\
                                --user "${_user}"\
                              --domain "${_domain}"
        done
    done
done
```

> Note `entr` and other file system monitoring APIs maybe more efficient than what the above is doing.


- 4. Notify _`Git`_/_`Jekyll`_ users that server is ready to utilize `git-shell-commands` within their respective home directories


- 5. If not using a `cron` job to keep web server configurations updated then use the `jekyll_wwwconf.sh` script's `--clobber` `append` or `remove` options for the desired results against a given `--repo`


___


## Directories


- [_`.github`_][source_github_dir] contains templates for GitHub interactions such as opening [_`Issues`_][issues]

- [_`git_shell_commands/`_][source_git_shell_commands_dir] contains [_`Git`_/_`Jekyll`_][docs_collection_git_shell_commands] client scripts that may be copied or linked via [using _`jekyll_usermod.sh`_][docs_jekyll_usermod] script

- [_`make_scriptlets/`_][source_make_scriptlets_dir] contains scripts used by [_`Makefile`_][source_makefile] for [_`make install`_][docs_install] and [_`make update`_][docs_update] commands; hint `make list` lists available `make` options

- [_`shared_functions/`_][source_shared_functions_dir] contains functions shared between scripts within root of project directory


## Administration Scripts


- [_`jekyll_usermod.sh`_][source_jekyll_usermod], adds new user, with ssh-pub-key (git-shell access only), and [_`installs`_][docs_jekyll_usermod] the following to the home directory of the new user;

    - _`Jekyll`_, for _translating_ MarkDown to HTML (HyperText Markup Language), just to list one of many things that _`Jekyll`'ll_ do
    - copy or link selected `git-shell-command` scripts, intended to simplify some of the repetitively redundant tasks involved with _`Git`_ and _`Jekyll`_ development
    - and initializes user named repo much like what GitHub makes available.

- [_`jekyll_dnsconf.sh`_][source_jekyll_dnsconf], adds `A` records for interface, group/domain, and TLD (Top Level Domain), currently _wired_ for Unbound DNS (Domain Name Server); note, some [_`usage examples`_][docs_jekyll_dnsconf] have been published for this script

- [_`jekyll_wwwconf.sh`_][source_jekyll_wwwconf], adds {sub-}domain names to web server for given user/repo, currently _wired_ for Nginx Web Server, check the published [_`usage examples`_][docs_jekyll_wwwconf] for examples of usage



[help_fork]: https://help.github.com/en/articles/fork-a-repo
[help_pull_request]: https://help.github.com/en/articles/about-pull-requests

[docs_home]: https://s0ands0.github.io/Jekyll_Admin/
[docs_collection_administration]: https://s0ands0.github.io/Jekyll_Admin/administration/
[docs_collection_git_shell_commands]: https://s0ands0.github.io/Jekyll_Admin/git_shell_commands/
[docs_license_tldr]: https://s0ands0.github.io/Jekyll_Admin/licensing/gnu-agpl/
[docs_collection_licensing]: https://s0ands0.github.io/Jekyll_Admin/licensing/
[docs_install]: https://s0ands0.github.io/Jekyll_Admin/administration/installation/
[docs_update]: https://s0ands0.github.io/Jekyll_Admin/administration/updating/
[docs_jekyll_dnsconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-dnsconf/
[docs_jekyll_usermod]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-usermod/
[docs_jekyll_wwwconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-wwwconf/

[branch_gh_pages]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[contributers]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/documentation/_contributors/
[contributing]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/documentation/_contributing/

[issues]: https://github.com/S0AndS0/Jekyll_Admin/issues
[license]: LICENSE
[source_jekyll_dnsconf]: jekyll_dnsconf.sh
[source_jekyll_usermod]: jekyll_usermod.sh
[source_jekyll_wwwconf]: jekyll_wwwconf.sh
[source_makefile]: Makefile
[source_travis_yml]: .travis.yml

[source_git_shell_commands_dir]: git_shell_commands/
[source_make_scriptlets_dir]: make_scriptlets/
[source_shared_functions_dir]: shared_functions/
[source_github_dir]: .github/

[badge_travis_ci]: https://travis-ci.com/S0AndS0/Jekyll_Admin.svg?branch=master
[build_travis_ci]: https://travis-ci.com/S0AndS0/Jekyll_Admin

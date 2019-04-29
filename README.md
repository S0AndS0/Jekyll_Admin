Collection of Bash scripts for Jekyll and Git server administration and interaction via `ssh` or `git` command-line tools.


> Unless otherwise stated both documentation and code are shared under the [_`GNU AGPL version 3`_][license-tldr] license by default, a full copy of which is available under [_`master:LICENSE`_][license]


[_`Documentation`_][docs_home] is hosted by GitHub Pages, the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][branch_gh-pages] `branch`. [_`Installation`_][docs_install], and [_`Update`_][docs_update] instructions are currently featured along with usage examples for [_`Administrators`_][docs_collection_administration] and [_`Git`/`Jekyll`_][docs_collection_git_shell_commands] clients.


To add features or fix issues within this project; start with making a [_`Fork`_][fork] of this repository, then make changes (testing if code related), and update the [`_contributers`][contributers] directory with a file about your self (and maybe a summery of changes) before issuing a [_`Pull Request`_][pull-request]. See the [_`Contributing`_][contributing] collection for examples of development setup and other tips.


___


### Directories


- [_`.github`_][source_github_dir] contains templates for GitHub interactions such as opening [_`Issues`_][issues]

- [_`git_shell_commands/`_][source_git_shell_commands_dir] contains [_`Git`_/_`Jekyll`_][docs_collection_git_shell_commands] client scripts that may be copied or linked via [using _`jekyll_usermod.sh`_][docs_jekyll_usermod] script

- [_`make_scriptlets/`_][source_make_scriptlets_dir] contains scripts used by [_`Makefile`_][source_makefile] for [_`make install`_][docs_install] and [_`make update`_][docs_update] commands; hint `make list` lists available `make` options

- [_`shared_functions/`_][source_shared_functions_dir] contains functions shared between scripts within root of project directory


### Administration Scripts


- [_`jekyll_usermod.sh`_][source_jekyll-usermod], adds new user, with ssh-pub-key (git-shell access only), and [_`installs`_][docs_jekyll_usermod] the following to the home directory of the new user;

    - _`Jekyll`_, for _translating_ MarkDown to HTML (HyperText Markup Language), just to list one of many things that _`Jekyll`'ll_ do
    - copy or link selected `git-shell-command` scripts, intended to simplify some of the repetitively redundant tasks involved with _`Git`_ and _`Jekyll`_ development
    - and initializes user named repo much like what GitHub makes available.

- [_`jekyll_dnsconf.sh`_][source_jekyll-dnsconf], adds `A` records for interface, group/domain, and TLD (Top Level Domain), currently _wired_ for Unbound DNS (Domain Name Server); note, some [_`usage examples`_][docs_jekyll_dnsconf] have been published for this script

- [_`jekyll_wwwconf.sh`_][source_jekyll-wwwconf], adds {sub-}domain names to web server for given user/repo, currently _wired_ for Nginx Web Server, check the published [_`usage examples`_][docs_jekyll_wwwconf] for examples of usage


[contributers]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_contributers/
[contributing]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_contributing/
[fork]: https://help.github.com/en/articles/fork-a-repo
[issues]: https://github.com/S0AndS0/Jekyll_Admin/issues
[license]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/LICENSE
[license-tldr]: https://s0ands0.github.io/Jekyll_Admin/licensing/2019-04-17-gnu-agpl.html
[pull-request]: https://help.github.com/en/articles/about-pull-requests

[branch_gh-pages]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[docs_home]: https://s0ands0.github.io/Jekyll_Admin/
[docs_collection_administration]: https://s0ands0.github.io/Jekyll_Admin/admin/
[docs_collection_git_shell_commands]: https://s0ands0.github.io/Jekyll_Admin/git_shell_commands/
[docs_collection_licensing]: https://s0ands0.github.io/Jekyll_Admin/licensing/
[docs_install]: https://s0ands0.github.io/Jekyll_Admin/administration/installation.html
[docs_update]: https://s0ands0.github.io/Jekyll_Admin/administration/updating.html
[docs_jekyll_dnsconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll_dnsconf.html
[docs_jekyll_usermod]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll_usermod.html
[docs_jekyll_wwwconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll_wwwconf.html


[source_jekyll-dnsconf]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
[source_jekyll-usermod]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_usermod.sh
[source_jekyll-wwwconf]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_wwwconf.sh
[source_makefile]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/Makefile

[source_git_shell_commands_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/git_shell_commands
[source_make_scriptlets_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/make_scriptlets
[source_shared_functions_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/shared_functions
[source_github_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/.github/

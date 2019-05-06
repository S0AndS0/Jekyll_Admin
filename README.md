Collection of Bash scripts for Jekyll and Git server administration and interaction via `ssh` or `git` command-line tools.


> Unless otherwise stated both documentation and code are shared under the [_`GNU AGPL version 3`_][license_tldr] license by default, a full copy of which is available under [_`master:LICENSE`_][license]


[_`Documentation`_][docs_home] is hosted by GitHub Pages, the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][branch_gh_pages] `branch`. [_`Installation`_][docs_install], and [_`Update`_][docs_update] instructions are currently featured along with usage examples for [_`Administrators`_][docs_collection_administration] and [_`Git`/`Jekyll`_][docs_collection_git_shell_commands] clients.


To add features or fix issues within this project; start with making a [_`Fork`_][fork] of this repository, then make changes (testing if code related), and update the [`_contributers`][contributers] directory with a file about your self (and maybe a summery of changes) before issuing a [_`Pull Request`_][pull_request]. See the [_`Contributing`_][contributing] collection for examples of development setup and other tips.


___


### Directories


- [_`.github`_][source_github_dir] contains templates for GitHub interactions such as opening [_`Issues`_][issues]

- [_`git_shell_commands/`_][source_git_shell_commands_dir] contains [_`Git`_/_`Jekyll`_][docs_collection_git_shell_commands] client scripts that may be copied or linked via [using _`jekyll_usermod.sh`_][docs_jekyll_usermod] script

- [_`make_scriptlets/`_][source_make_scriptlets_dir] contains scripts used by [_`Makefile`_][source_makefile] for [_`make install`_][docs_install] and [_`make update`_][docs_update] commands; hint `make list` lists available `make` options

- [_`shared_functions/`_][source_shared_functions_dir] contains functions shared between scripts within root of project directory


### Administration Scripts


- [_`jekyll_usermod.sh`_][source_jekyll_usermod], adds new user, with ssh-pub-key (git-shell access only), and [_`installs`_][docs_jekyll_usermod] the following to the home directory of the new user;

    - _`Jekyll`_, for _translating_ MarkDown to HTML (HyperText Markup Language), just to list one of many things that _`Jekyll`'ll_ do
    - copy or link selected `git-shell-command` scripts, intended to simplify some of the repetitively redundant tasks involved with _`Git`_ and _`Jekyll`_ development
    - and initializes user named repo much like what GitHub makes available.

- [_`jekyll_dnsconf.sh`_][source_jekyll_dnsconf], adds `A` records for interface, group/domain, and TLD (Top Level Domain), currently _wired_ for Unbound DNS (Domain Name Server); note, some [_`usage examples`_][docs_jekyll_dnsconf] have been published for this script

- [_`jekyll_wwwconf.sh`_][source_jekyll_wwwconf], adds {sub-}domain names to web server for given user/repo, currently _wired_ for Nginx Web Server, check the published [_`usage examples`_][docs_jekyll_wwwconf] for examples of usage



[fork]: https://help.github.com/en/articles/fork-a-repo
[pull_request]: https://help.github.com/en/articles/about-pull-requests

[license_tldr]: https://s0ands0.github.io/Jekyll_Admin/licensing/gnu-agpl/
[docs_home]: https://s0ands0.github.io/Jekyll_Admin/
[docs_collection_administration]: https://s0ands0.github.io/Jekyll_Admin/administration/
[docs_collection_git_shell_commands]: https://s0ands0.github.io/Jekyll_Admin/git_shell_commands/
[docs_collection_licensing]: https://s0ands0.github.io/Jekyll_Admin/licensing/
[docs_install]: https://s0ands0.github.io/Jekyll_Admin/administration/installation/
[docs_update]: https://s0ands0.github.io/Jekyll_Admin/administration/updating/
[docs_jekyll_dnsconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-dnsconf/
[docs_jekyll_usermod]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-usermod/
[docs_jekyll_wwwconf]: https://s0ands0.github.io/Jekyll_Admin/administration/jekyll-wwwconf/

[branch_gh_pages]: /tree/gh-pages
[contributers]: /tree/gh-pages/documentation/_contributors/
[contributing]: /tree/gh-pages/documentation/_contributing/

[issues]: /issues
[license]: /blob/master/LICENSE
[source_jekyll_dnsconf]: /blob/master/jekyll_dnsconf.sh
[source_jekyll_usermod]: /blob/master/jekyll_usermod.sh
[source_jekyll_wwwconf]: /blob/master/jekyll_wwwconf.sh
[source_makefile]: /blob/master/Makefile

[source_git_shell_commands_dir]: /tree/master/git_shell_commands
[source_make_scriptlets_dir]: /tree/master/make_scriptlets
[source_shared_functions_dir]: /tree/master/shared_functions
[source_github_dir]: /tree/master/.github/

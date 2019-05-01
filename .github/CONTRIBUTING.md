Please see the [Contributing][docs_contributing] collection for examples of remote server setup designed for faster testing during development. Basically boils down to...


- [_`Fork`ing_][fork_link] this repository to your own GitHub account


... then installing for one of the following options;


- [Administration][docs_dev_admin] development such as bug fixes or adding features to; [`Makefile`][source_makefile], [`jekyll_usermod.sh`][source_jekyll_usermod], [`jekyll_dnsconf`][source_jekyll_dnsconf], and/or [`jekyll_wwwconf`][source_jekyll_wwwconf] scripts.

- [Git Shell Commands][docs_dev_commands] development such as adding new scripts or fixing bugs within the [`git_shell_commands`][dir_git_shell_commands] directory of this project.

- [Documentation][docs_dev_pages] corrections and/or expansions on code or raw source documentation contained within this project's [`gh-pages`][pages_branch] branch


Testing changes on a local or private server, before merging with something like [_`git merge --squash`**`dev-branch-name`**_][docs_dev_merge] and _`push`ing_ to your forked version via something like *`git push`**`remote-name`**__`branch-name`__*.


After which a [Pull Request][docs_dev_pull_request] may be issued for this project's maintainers to review.


[pages_branch]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[fork_link]: https://github.com/S0AndS0/Jekyll_Admin/fork
[fork_list]: https://github.com/S0AndS0/Jekyll_Admin/network/members

[docs_contributing]: https://s0ands0.github.io/Jekyll_Admin/contributing/
[docs_dev_admin]: https://s0ands0.github.io/Jekyll_Admin/contributing/install-master/
[docs_dev_commands]: https://s0ands0.github.io/Jekyll_Admin/contributing/install-git-shell-commands/
[docs_dev_pages]: https://s0ands0.github.io/Jekyll_Admin/contributing/install-gh-pages/
[docs_dev_merge]: https://s0ands0.github.io/Jekyll_Admin/contributing/merge/
[docs_dev_pull_request]: https://s0ands0.github.io/Jekyll_Admin/contributing/pull-request/

[dir_git_shell_commands]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/git_shell_commands
[source_makefile]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/Makefile
[source_jekyll_usermod]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_usermod.sh
[source_jekyll_dnsconf]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
[source_jekyll_wwwconf]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_wwwconf.sh

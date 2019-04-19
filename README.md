Collection of Bash scripts for Jekyll and Git server administration.


> Unless otherwise stated both documentation and code are shared under the "[GNU AGPL version 3][license-tldr]" license by default, a full copy of which is available under [_`master:LICENSE`_][license]


[Documentation][gh-pages] is hosted by GitHub Pages, the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][gh-pages-source] `branch`. [Installation][install], and [Update][update] instructions are currently featured along with some example `Usage`.


[`Fork`][fork] this repository to add features, once tested and the `contributers.md` file has been updated issue a [`Pull Request`][pull-request] to have your changes reviewed and possibly merged into the code base.


___


- `shared_functions/`, contains functions shared between scripts within root of project directory

- [`jekyll_dnsconf.sh`][jekyll-dnsconf_source], adds `A` records for interface, group/domain, and TLD (Top Level Domain)

- [`jekyll_wwwconf.sh`][jekyll-wwwconf_source], adds {sub-}domain names to web server for given user/repo

- [`jekyll_usermod.sh`][jekyll-usermod_source], adds new user, with ssh-pub-key (git-shell access only), and _installs_ the following to the home directory of the new user;

    - _`Jekyll`_, for _translating_ MarkDown to HTML (HyperText Markup Language), just to list one of many things that _`Jekyll`'ll_ do
    - copy or link selected `git-shell-command` scripts, intended to simplify some of the repetitively redundant tasks involved with _`Git`_ and _`Jekyll`_ development
    - and initializes user named repo much like what GitHub makes available.


[license]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/LICENSE
[license-tldr]: https://s0ands0.github.io/Jekyll_Admin/licenses/2019/04/17/gnu-agpl.html
[gh-pages-source]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[gh-pages]: https://s0ands0.github.io/Jekyll_Admin/
[install]: https://s0ands0.github.io/Jekyll_Admin/install/
[update]: https://s0ands0.github.io/Jekyll_Admin/update/

[fork]: https://help.github.com/en/articles/fork-a-repo
[pull-request]: https://help.github.com/en/articles/about-pull-requests

[jekyll-dnsconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
[jekyll-usermod_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_usermod.sh
[jekyll-wwwconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_wwwconf.sh

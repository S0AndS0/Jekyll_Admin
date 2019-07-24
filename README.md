<sub>[![Build Status][badge_travis_ci]][build_travis_ci]</sub> means that tests defined within the [`travis.yml`][gh_pages_travis_yml] configuration file either _passed_, _failed_, etc. as of <sub>[![Last Commit][badge_last_commit_gh_pages]][commits_gh_pages]</sub>.


___


Collection of Bash scripts for Jekyll and Git server administration and interaction via `ssh` or `git` command-line tools.


> Unless otherwise stated both documentation and Bash scripts are shared under <sub>[![License][badge_license]][docs_license_tldr]</sub> (version `3`) by default, a full copy of which is available under [_`master:LICENSE`_][license]. See the [Licensing][docs_licensing] collection for when others may apply.


<sub>[![Documentation][badge_docs_hosting]][docs_home]</sub> provides rendered documentation for this project; the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][branch_gh_pages] `branch`. [_`Installation`_][docs_install], and [_`Update`_][docs_update] instructions are currently featured along with usage examples for [_`Administrators`_][docs_administration] and [_`Git`/`Jekyll`_][docs_git-shell-commands] clients.


<sub>[![Pull Requests friendly][badge_pr_requests]][help_pull_request]</sub>, however, please review GitHub's [`Fork`][help_fork] help page, and the [_`Contributing`_][docs_contributing] collection of this project for set-up and [styling][docs_styling] tips. Oh and don't forget to add yourself to the [Contributors][dir_contributers] collection before first Pull Request.


Consider checking [Supporting Options][docs_support] for methods of encouraging projects like these.


___


### Documentation Collections


> The following use the [_`_layouts/modules/collection-home/collection-home`_][gh_pages_layouts_collections_home_source] _`Layout`_ by default.


- [_`_administration`_][gh_pages_administration_dir] directory is complied into [_`<host>/administration/`_][docs_administration] collection of entries as configured by [_`administration.markdown`_][gh_pages_administration_source]

- [_`_git-shell-commands`_][gh_pages_git-shell-commands_dir] directory is complied into [_`<host>/git-shell-commands/`_][docs_git-shell-commands] collection of entries as configured by [_`git-shell-commands.markdown`_][gh_pages_git-shell-commands_source]

- [_`_contributing`_][gh_pages_contributing_dir] directory is complied into [_`<host>/contributing/`_][docs_contributing] collection of entries as configured by [_`contributing.markdown`_][gh_pages_contributing_source]

- [_`_contributors`_][gh_pages_contributers_dir] directory is complied into [_`<host>/contributers/`_][docs_contributers] collection of entries as configured by [_`contributers.markdown`_][gh_pages_contributers_source]

- [_`_licensing`_][gh_pages_licensing_dir] directory is complied into [_`<host>/licensing/`_][docs_licensing]collection of entries as configured by [_`licensing.markdown`_][gh_pages_licensing_source]

- [_`_security`_][gh_pages_security_dir] directory is complied into [_`<host>/security/`_][docs_security] collection of entries as configured by [_`security.markdown`_][gh_pages_security_source]

- [_`_styling`_][gh_pages_styling_dir] directory is complied into [_`<host>/styling/`_][docs_styling] collection of entries as configured by [_`styling.markdown`_][gh_pages_styling_source]


### Sources


- [_`_includes`_][gh_pages_includes_dir] directory contains files that maybe included within other source, page, or post files via Liquid similar to; `{%- include file-name named_arg='some value' -%}`

- [_`_layouts`_][gh_pages_layouts_dir] directory contains files that posts, pages, and other Front-Matter files may choose via something like `layout: name-of-layout` within the file's configuration block

- [_`_scss`_][gh_pages_scss_dir] or `_sass` directories contains `.scss` or `.sass` files that when included within the [_`assets`_][gh_pages_assets_dir] directory may use during `jekyll build` or `serve` operations to build site `.css` style sheets.

- [_`assets`_][gh_pages_assets_dir] directory contains `.scss` or `.sass` files that are _transmuted_ into `.css` files, and in the future may contain image and/or JavaScript files, all of which are accessible by other site source files, pages, and/or posts



[help_fork]: https://help.github.com/en/articles/fork-a-repo
[help_pull_request]: https://help.github.com/en/articles/about-pull-requests

[gh_pages-source]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[gh_pages]: https://s0ands0.github.io/Jekyll_Admin/
[branch_gh_pages]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[commits_gh_pages]: https://github.com/S0AndS0/Jekyll_Admin/commits/gh-pages

[gh_pages_includes_dir]: _includes
[gh_pages_layouts_dir]: _layouts
[gh_pages_scss_dir]: _scss
[gh_pages_assets_dir]: assets


[gh_pages_layouts_collections_home_source]: _layouts/modules/collection-home/collection-home
[gh_pages_layouts_collections_feeds_rss_entries_source]: _layouts/modules/feed-rss2/feed-rss2
[gh_pages_layouts_collections_feeds_atom_entries_source]: _layouts/modules/feed-atom/feed-atom

[gh_pages_administration_dir]: documentation/_administration
[gh_pages_administration_source]: administration.markdown

[gh_pages_git-shell-commands_dir]: documentation/_git-shell-commands
[gh_pages_git-shell-commands_source]: git-shell-commands.markdown

[gh_pages_licensing_dir]: documentation/_licensing
[gh_pages_licensing_source]: licensing.markdown

[gh_pages_contributing_dir]: documentation/_contributing
[gh_pages_contributing_source]: documentation/_contributing/contributing.markdown

[gh_pages_contributers_dir]: documentation/_contributers
[gh_pages_contributers_source]: documentation/_contributers/contributers.markdown

[gh_pages_security_dir]: documentation/_security
[gh_pages_security_source]: documentation/_security/security.markdown

[gh_pages_styling_dir]: documentation/_styling
[gh_pages_styling_source]: documentation/_styling/styling.markdown

[gh_pages_travis_yml]: .travis.yml


[license]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/LICENSE
[docs_home]: https://s0ands0.github.io/Jekyll_Admin/
[docs_license_tldr]: https://s0ands0.github.io/Jekyll_Admin/licensing/gnu-agpl/
[docs_licensing]: https://s0ands0.github.io/Jekyll_Admin/licensing/
[docs_update]: https://s0ands0.github.io/Jekyll_Admin/administration/updating/
[docs_administration]: https://s0ands0.github.io/Jekyll_Admin/administration/
[docs_git-shell-commands]: https://s0ands0.github.io/Jekyll_Admin/git-shell-commands/
[docs_contributing]: https://s0ands0.github.io/Jekyll_Admin/contributing/
[docs_styling]: https://s0ands0.github.io/Jekyll_Admin/styling/
[dir_contributers]: documentation/_contributors/
[docs_contributers]: https://s0ands0.github.io/Jekyll_Admin/contributers/
[docs_security]: https://s0ands0.github.io/Jekyll_Admin/security/
[docs_styling]: https://s0ands0.github.io/Jekyll_Admin/styling/
[docs_support]: https://s0ands0.github.io/Jekyll_Admin/support/
[docs_install]: https://s0ands0.github.io/Jekyll_Admin/administration/installation/
[docs_updating]: https://s0ands0.github.io/Jekyll_Admin/administration/updating/


[build_travis_ci]: https://travis-ci.com/S0AndS0/Jekyll_Admin

[badge_travis_ci]: https://travis-ci.com/S0AndS0/Jekyll_Admin.svg?branch=gh-pages
[badge_last_commit_gh_pages]: https://img.shields.io/github/last-commit/S0AndS0/Jekyll_Admin/gh-pages.svg?color=005571
[badge_docs_hosting]: https://img.shields.io/website/https/s0ands0.github.io/Jekyll_Admin.svg?down_color=darkred&down_message=Offline&label=GitHub%20Pages&logo=github&logoColor=lightgreen&up_color=005571&up_message=Online

[badge_license]: https://img.shields.io/github/license/S0AndS0/Jekyll_Admin.svg?color=005571
[badge_pr_requests]: https://img.shields.io/badge/Pull_Request-friendly-005571.svg

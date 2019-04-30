Collection of Bash scripts for Jekyll and Git server administration and interaction via `ssh` or `git` command-line tools.


> Unless otherwise stated both documentation and code are shared under the "[_`GNU AGPL version 3`_][license-tldr]" license by default, a full copy of which is available under [_`master:LICENSE`_][license]


[_`Documentation`_][gh-pages] is hosted by GitHub Pages, the source code modifications and _raw_ doc-files of which can be found under the [_`gh-pages`_][gh-pages-source] `branch`. [_`Installation`_][install], and [_`Update`_][update] instructions are currently featured along with usage examples for [_`Administrators`_][collection_administration] and [_`Git`/`Jekyll`_][collection_git_shell_commands] clients.


[_`Fork`_][fork] this repository to add features, once tested and the `contributers.md` file has been updated issue a [_`Pull Request`_][pull-request] to have your changes reviewed and possibly merged into the code base.


___


### Collections (topics)


> The following use the [_`_layouts/collections/home.html`_][gh-pages_layouts_collections_home_source] _`Layout`_ by default.


- [_`_administration`_][gh-pages_administration_dir] directory is complied into [_`<host>/admin/`_][collection_administration] collection of entries as configured by [_`administration.md`_][gh-pages_administration_source]

- [_`_git_shell_commands`_][gh-pages_git_shell_commands_dir] directory is complied into [_`<host>/git_shell_commands/`_][collection_git_shell_commands] collection of entries as configured by [_`git_shell_commands`_][gh-pages_git_shell_commands_source]

- [_`_licensing`_][gh-pages_licensing_dir] directory is complied into [_`<host>/licensing/`_][collection_licensing]collection of entries as configured by [_`licensing.md`_][gh-pages_licensing_source]


### Sources


- [_`_includes`_][gh-pages_includes_dir] directory contains files that maybe included within other source, page, or post files via Liquid similar to; `{%- include file-name named_arg='some value' -%}`

- [_`_layouts`_][gh-pages_layouts_dir] directory contains files that posts, pages, and other Front-Matter files may choose via something like `layout: name-of-layout` within the file's configuration block

- [_`_scss`_][gh-pages_scss_dir] directory contains files that `.scss` or `.sass` files within the [_`assets`_][gh-pages_assets_dir] directory may use during `jekyll build` or `serve` operations to build site `.css` styles

- [_`assets`_][gh-pages_assets_dir] directory contains `.scss` or `.sass` files that are _transmuted_ into `.css` files, and in the future may contain image and/or JavaScript files, all of which are accessible by other site source files, pages, and/or posts


[license]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/LICENSE
[license-tldr]: https://s0ands0.github.io/Jekyll_Admin/licensing/gnu-agpl.html
[gh-pages-source]:https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages
[gh-pages]: https://s0ands0.github.io/Jekyll_Admin/
[install]: https://s0ands0.github.io/Jekyll_Admin/administration/installation.html
[update]: https://s0ands0.github.io/Jekyll_Admin/administration/updating.html

[fork]: https://help.github.com/en/articles/fork-a-repo
[pull-request]: https://help.github.com/en/articles/about-pull-requests

[gh-pages_administration_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_administration
[collection_administration]: https://s0ands0.github.io/Jekyll_Admin/admin/
[gh-pages_administration_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/administration.md

[gh-pages_git_shell_commands_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_git_shell_commands
[collection_git_shell_commands]: https://s0ands0.github.io/Jekyll_Admin/git_shell_commands/
[gh-pages_git_shell_commands_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/git_shell_commands.md

[gh-pages_licensing_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_licensing
[collection_licensing]: https://s0ands0.github.io/Jekyll_Admin/licensing/
[gh-pages_licensing_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/licensing.md


[gh-pages_includes_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_includes
[gh-pages_layouts_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_layouts
[gh-pages_scss_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/_scss
[gh-pages_assets_dir]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/assets


[gh-pages_layouts_collections_home_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/_layouts/collections/home.html
[gh-pages_layouts_collections_feeds_rss_entries_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/_layouts/collections/feeds/rss2_entries.html
[gh-pages_layouts_collections_feeds_atom_entries_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/gh-pages/_layouts/collections/feeds/atom_entries.html


[gh-pages_]: example.com

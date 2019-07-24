---
layout: post
title:  GitHub Pages Branch Development Installation
date:   2019-04-26 11:12:11 -0700
description: Utilizing this project's scripts to test and develop documentation for this project
---

First setup the remote server with [`make install`][docs_install], then see the examples for [adding _`Git`_/_`Jekyll`_][docs_jekyll_usermod] users, adding _dev_ groups to [DNS configurations][docs_jekyll_dnsconf], updating [Web Server][docs_jekyll_wwwconf] configurations with new project documentation paths, and then [adding GitHub API][docs_edit_configs] key examples for less error pone building with [GitHub Meta-Data][help_github_metadata] on a private server.


> These instructions use a `~/.ssh/confg` similar to the following...


```
Host git_joan
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User Joanna
```


> ... and for `sudo` level commands something like...


```
Host joan
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User joan
```


___


Within a local terminal utilize the [`jekyll_wwwconf.sh`][docs_jekyll_wwwconf] script again to add `Jekyll_Admin` to the Web Server configurations...


```bash
ssh joan sudo jekyll_wwwconf.sh\
 --user='Joanna'\
 --group='devs'\
 --interface='eth0'\
 --tld='lan'\
 --server='nginx'\
 --repo='Jekyll_Admin'\
 --help
```


Within a local terminal change directories to where this project is `clone`d to and incant...


```bash
cd ~/github/Jekyll_Admin

## Add a `dev` remote pointing to private server
git remote add dev git_joan:git/Jekyll_Admin

## Checkout the gh-pages branch
git checkout gh-pages

## Track changes within a local branch
git checkout -b local_gh-pages

## Generate a Jekyll repo on the remote
##  server via git-shell-commands script
ssh git_joan jekyll-init Jekyll_Admin

## Push local branch to private server
git push --force dev local_gh-pages:gh-pages
```


> Note, the _`git push`**`--force`**`<remote> <local_branch>:<remote_branch>`_ is usually only necessary the first time around, future _`push`es_ could look like _`git push dev local_gh-pages:gh-pages`_


Install Jekyll and Gem related dependencies via [`bundle-install`][docs_bundle_install] `git-shell-commands` script...


```bash
ssh git_joan bundle-install Jekyll_Admin
```


Utilizing the [`jekyll-build`][docs_jekyll_build] `git-shell-commands` script after each _`git push dev`_ would look like...


```bash
ssh git_joan jekyll-build Jekyll_Admin
```


Once local changes are bug-free see [`git merge local_gh-pages`][docs_merge] examples, and [Pull Request][docs_pull_request] tips.



[docs_install]: /Jekyll_Admin/administration/installation/
[docs_jekyll_usermod]: /Jekyll_Admin/administration/jekyll-usermod/
[docs_jekyll_dnsconf]: /Jekyll_Admin/administration/jekyll-dnsconf/
[docs_jekyll_wwwconf]: /Jekyll_Admin/administration/jekyll-wwwconf/

[docs_bundle_install]: /Jekyll_Admin/git-shell-commands/bundle-install/
[docs_jekyll_build]: /Jekyll_Admin/git-shell-commands/jekyll-build/
[docs_edit_configs]: /Jekyll_Admin/git-shell-commands/edit-configs/

[docs_merge]: /Jekyll_Admin/contributing/merge/
[docs_pull_request]: /Jekyll_Admin/contributing/pull-request/

[help_github_metadata]: https://help.github.com/en/articles/repository-metadata-on-github-pages

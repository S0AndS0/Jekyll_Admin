---
layout: post
title: Git Checkout Branch
date: 2019-04-25 11:12:14 -0700
categories: git_shell_commands
description: Short-cut for `git checkout` or `git -b checkout` for named repository
---

The [`git-checkout`][source_master__git-checkout] script satisfies a niche need that occasionally arises to checkout a branch on a remote server.


As an example suppose that _`Bill`_ has a repository `Sweet_Playlist` on GitHub or another remote server, and wants to test things on the server the _`Elizabeth`_ and _`Joanna`_ have set up.


_`Bill`_ might command their local terminal with...


```bash
ssh bill git-init Sweet_Playlist

cd ~/where-ever-is/Sweet_Playlist
git remote add srv bill:git/Sweet_Playlist

git push --force srv master
git push srv gh-pages
```

- `srv` is an arbitrary name, much like `origin` so `git` knows which _`remote`_ _`Bill`_ is _`push`ing_ or _`pull`ing_ with.

- the `bill:git/Sweet_Playlist` targets `bill` within `~/.ssh/confg`, at the remote path of `git/Sweet_Playlist`.

- `--force` should be treated with care if the remote repository is shared or `git pull`/`clone` is intended


> Note, where _`Bill`_ a perfectionist they might instead use `git remote add srv bill:/srv/Bill/git/Sweet_Playlist` as **`/srv/Bill/`** includes the full remote path for the their `git` repository


Before _`Bill`_ can use the `jekyll-build` script they'd first need to `checkout` the `gh-pages` branch on the server...


```bash
ssh bill git-checkout gh-pages Sweet_Playlist
```


> Note, if the `gh-pages` branch did not already exist the above might instead be `ssh bill git-checkout`**` -b `**`gh-pages Sweet_Playlist`


... then install any plug-ins defined by either `_config.yml` or `Gemfiles` would look like...


```bash
ssh bill bundle-install Sweet_Playlist
```


... at which point _`Bill`_ could use the `jekyll-build` script after every push like usual...


```bash
ssh bill jekyll-build Sweet_Playlist
```


[source_master__git-checkout]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/git-checkout

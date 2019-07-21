---
layout: post
title:  Git Shell Commands Development
date:   2019-04-27 11:12:11 -0700
description: Quick how-to submit patches to the git-shell-commands scripts
---

Supposing the _`Bill`_ has done something _interesting_ to gain `push` and `pull` permissions to their `git-shell-commands` directory, not saying what or how, but now maybe...


```bash
mkdir -p ~/git/srv

cd ~/git/srv
git clone bill:/srv/Bill/git-shell-commands
```


... _means something_ to _`Git`_, as does...


```bash
cd ~/git/srv/git-shell-commands

git push origin master
```


... then _`Bill`_ could perhaps patch whatever bug they found while the administrators where otherwise too occupied to _pop-in_ and checkup on progress, starting with...


```bash
mkdir -p ~/git/hub
cd ~/git/hub
git clone git@github.com:<GitHub-UserName>/git-shell-commands.git

cd git-shell-commands
git checkout -b local_commands
```


> Note, _`<GitHub-UserName>`_ would need to be replaced by _`Bill`'s_ GitHub user name for the above to work properly.


... then by copying the patched version with something like...


```bash
cp ~/git/srv/git-shell-commands/patched-script ./
```


... And after adding themselves to the [`_contributors`][dir_contributors] directory within this project's `gh-pages` `branch`, and [Merging][docs_merge] changes _`Bill`_ could issue a [Pull Request][docs_pull_request] for review by this project's maintainers.



[dir_contributors]: https://github.com/S0AndS0/Jekyll_Admin/tree/gh-pages/documentation/_contributors

[docs_merge]: /Jekyll_Admin/contributing/merge/
[docs_pull_request]: /Jekyll_Admin/contributing/pull-request/

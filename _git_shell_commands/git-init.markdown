---
layout: post
title: Git Initialize
date:   2019-04-19 11:12:17 -0700
categories: git_shell_commands
excerpt: >-
  The `git-init` client script makes new repositories under `${HOME}/git` ready for `git clone` and/or `git push` operations
---


Perhaps both _`Bill`_ and _`Ted`_ want to share a repository for `Ideas`, supposing _`Bill`_ _won_ the _coin-toss_, they might gleefully use the the [`git-init`][source_master__git-init] script with the following options at their local terminal...


```bash
ssh Bill git-init --shared Ideas
```


_`Bill`_ could then `clone` via...


```bash
cd ~/git

git clone Bill:git/Ideas
```


And _`Ted`_ could `clone` almost like...


```bash
cd ~/git

git clone Ted:/srv/Bill/git/Ideas
```


Either could then...


```bash
cd ~/git/Ideas
```


... and make modifications, and issue `git push`/`pull`/`fetch` commands to keep the shared `Ideas` repository updated.


------


Maybe _`Ted`_ wants to track some `Radical_Features` on their own, which would look something like...


```bash
ssh Ted git-init Radical_Features

cd ~/git
git clone Ted:git/Radical_Features

cd ~/git/Radical_Features
```


... and while _`Bill`_ could _check-out_ `Radical_Features` with...


```bash
cd ~/git

git clone Bill:/srv/Ted/git/Radical_Features
cd ~/git/Radical_Features
```


... because, their both in the same group (`devs` in the running example's case), this is allowed. However, _`Bill`_ would not immediately be able to `git push` to _`Ted`'s_ `Radical_Features` repository.


[source_master__git-init]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/git-init

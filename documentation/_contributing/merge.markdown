---
layout: post
title: Merge Development Branch
date:  2019-04-28 11:12:11 -0700
description: Tips for a happy _`squash`ed_ `git merge` of `local_` branches
---

Merging changed from `local_master` to _`fork`ed_ `master`...


```bash
git checkout master

git merge --squash local_master
```


Merging changed from `local_gh-pages` to _`fork`ed_ `gh-pages`...


```bash
git checkout gh-pages
git merge --strategy-option theirs --squash local_gh-pages
```


> Note, please only use options like _`--strategy-option theirs`_ when confident in the outcome.


___


In any-case summarizing changes in a nicely formatted `comment` message might look like the following for closing issue `#9001`...


```bash
git comment -F- <<EOF
$(git config user.name) fixed S0AndS0/Jekyll_Admin/#9001 bug

## ... summary of changes or gotchas found
##     may go here if there are many changes,
##     otherwise feel free to be concise.
EOF
```


... or perhaps something like the following for adding features...


```bash
git comment -F- <<EOF
$(git config user.name) added features to S0AndS0/Jekyll_Admin

## ... summary of things project is now
##     capable of doing __must__ go here.
EOF
```


... or for adding documentation something like...


```bash
git comment -F- <<EOF
$(git config user.name) added new documentation for S0AndS0/Jekyll_Admin:gh-pages

## ... Maybe copy/paste the description
##     from documentation post or page
EOF
```


In other-words try to keep pre-merge `commits` _targeted_ for swifter review.


___


Then _`git push`ing_ to the _`fork`ed_ `master` branch would look sorta like the following for those like _`Joanna`_ who initially _`fork`ed_ and then cloned...


```bash
git push origin master
```


Where as pushing to `gh-pages` `fork` might look like the next be for those like _`Elizabeth`_ who _`fork`ed_ after cloning this project's source...


```bash
git push fork gh-pages
```


Next see [Pull Request][docs_pull_request] tips for notifying this project's maintainers of suggested changes.



[github_help_fork]: https://help.github.com/en/articles/fork-a-repo

[fork_link]: https://github.com/S0AndS0/Jekyll_Admin/fork
[fork_list]: https://github.com/S0AndS0/Jekyll_Admin/network/members

[collection_home]: /Jekyll_Admin/contributing/
[docs_pull_request]: /Jekyll_Admin/contributing/pull-request/

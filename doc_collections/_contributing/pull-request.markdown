---
layout: post
title:  Pull Request
date:   2019-04-29 11:12:11 -0700
description: Tips for issuing Pull Requests
---

GitHub has documented very thoroughly the process of creating a Pull Request from a [fork][github_help_pull_request], as well as [usage][github_help_pull_request_usage] tips on Pull Requests, and how to [create][github_help_pull_request_create] Pull Requests. If the documentation here and on GitHub are found to be lacking, then please either make a Pull Request or [Open an Issue][issue_link].


Additionally please don't forget to add or update the relative _`_contributors/<GitHub-UserName>.markdown`_ file, eg...


### Example `_contributors/<GitHub-UserName>.markdown`


```
---
layout: post
title:  <GitHub-UserName>
date:   2019-04-01 11:12:11 -0700
url:    https://example.com/index.html
---

Something about contributions to project,
or about the person(s) behind the changes,
etc...
```


... prior to making first Pull Request, subsequent requests this is not required though updating anything out of date is a solid idea.

___


Once [logged-in][github_join] to GitHub anyone may [fork][fork_link] this repository, do the _`git push`_ things to their fork, then issue a Pull Request to either the [_`master`_][pull_link_master] or [_`gh-pages`_][pull_link_gh-pages] branches. After review, the changes may be merged by this project's maintainers as shown via GitHub's [_squashed_ Pull Request][github_help_pull_request_merge_about] documentation, see [Pull Request Merge][github_help_pull_request_merge] if curious as to what that looks like, or further edits will be requested in the form of opening an issue within the forked repository, eg. _`https://github.com/<GitHub-UserName>/Jekyll_Admin/issues`_



[github_join]: https://github.com/join
[github_help_pull_request]: https://help.github.com/en/articles/creating-a-pull-request-from-a-fork
[github_help_pull_request_usage]: https://help.github.com/articles/using-pull-requests
[github_help_pull_request_create]: https://help.github.com/en/articles/creating-a-pull-request#changing-the-branch-range-and-destination-repository
[github_help_pull_request_merge]: https://help.github.com/en/articles/merging-a-pull-request
[github_help_pull_request_merge_about]: https://help.github.com/en/articles/about-pull-request-merges

[fork_link]: https://github.com/S0AndS0/Jekyll_Admin/fork
[fork_list]: https://github.com/S0AndS0/Jekyll_Admin/network/members

[pull_link_master]: https://github.com/S0AndS0/Jekyll_Admin/pull/new/master
[pull_link_gh-pages]: https://github.com/S0AndS0/Jekyll_Admin/pull/new/gh-pages
[pull_list]: https://github.com/S0AndS0/Jekyll_Admin/pulls

[issue_link]: https://github.com/S0AndS0/Jekyll_Admin/issues/new/choose
[issue_list]: https://github.com/S0AndS0/Jekyll_Admin/issues

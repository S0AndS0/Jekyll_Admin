---
layout: post
title: Edit Configurations
date:   2019-04-19 11:12:16 -0700
categories: git_shell_commands
excerpt: >-
  The `edit-configs` client script is currently wired to allow adding GitHub API token configurations to `${HOME}/.config/jekyll-build` directory
---


For an example, let's suppose that _`Ted`_ wanted to use the GitHub API for their user named repository, knowing about the [`edit-configs`][source_master__edit-configs] script at their disposal they may then issue the following commands...


```bash
ssh Ted edit-configs --github-api-token="$(<"/path/to/github_api.token")"

cd ~/git
git clone Ted:git/Ted -o private-server

cd ~/git/Ted
```

... then make the edits to their site's source, and _`push`-n-`build`_ via...


```bash
git push private-server gh-pages

ssh Ted jekyll-build Ted
```


[source_master__edit-configs]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/edit-configs

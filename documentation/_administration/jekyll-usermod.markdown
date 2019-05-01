---
layout: post
title:  Jekyll User Modifier
date:   2019-04-18 11:12:13 -0700
description: The `jekyll_usermod.sh` administration script adds new `Git`/`Jekyll` users to private server
---


By default new users are __not__ allowed to `clone` and/or `push` to their respective [`git-shell-commands/`][git-shell-commands_source] directories, but this may change in future revisions.


Available options may be listed via `jekyll_usermod.sh --help`; [source][jekyll-usermod_source] is also available for auditing prior to issuing a `git clone`.


___


Perhaps _`Joanna`_ will add _`Bill`_ first to the private server via...


```bash
ssh joan sudo jekyll_usermod.sh\
 --user="Bill"\
 --group="devs"\
 --ssh-auth-keys="/server-path-to-bills/pub.key"\
 --help
```


Assuming that _`Bill`_ has the following configurations within their local `.ssh/config`...


```
Host bill
   HostName <host-or-IP-goes-here>
   User Bill
   IdentitiesOnly yes
   IdentityFile ~/.ssh/bills-private-key
```

_`Bill`_ may now list the available `git-commands` via...


```bash
ssh Bill list --help
```


Which may output something like...


```
-rwxr-xr-x 1 Bill devs ... bundle-install
-rwxr-xr-x 1 Bill devs ... bundle-update
-rwxr-xr-x 1 Bill devs ... copy-theme
-rwxr-xr-x 1 Bill devs ... edit-configs
-rwxr-xr-x 1 Bill devs ... git-init
-rwxr-xr-x 1 Bill devs ... git-set-permissions
-rwxr-xr-x 1 Bill devs ... jekyll-build
-rwxr-xr-x 1 Bill devs ... jekyll-init
-rwxr-xr-x 1 Bill devs ... list
-rwxr-xr-x 1 Bill devs ... repo-remove
drwxr-xr-x 2 Bill devs ... shared_functions
-rwxr-xr-x 1 Bill devs ... www-remove
-rwxr-xr-x 1 Bill devs ... www-set-permissions
```


-------


If at a later point _`Elizabeth`_ wants to add _`Ted`_, who is also apart of the `devs` group, however let's also suppose that the administrator trusts _`Ted`_ a bit more to stay _on-track_ than _`Bill`_, which may look similar to...


```bash
ssh admin sudo jekyll_usermod.sh\
 --user="Ted"\
 --group="devs"\
 --git-shell-copy-or-link="pushable"\
 --ssh-auth-keys="'$(</path-to-teds/pub.key)'"\
 --help
```


> Note in above that the `--ssh-auth-keys` value is double and single quoted in a specific order to ensure that argument parsing does not get confused.


... not that they don't trust _`Bill`_, more that they trust that _`Bill`_ will do something _interesting_ to get the same permissions as _`Ted`_.


[git-shell-commands_source]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/git_shell_commands
[jekyll-usermod_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_usermod.sh

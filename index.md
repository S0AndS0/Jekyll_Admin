---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

Administration has been split into separate scripts with specific & shared functions


- `shared_functions/` Contains functions for scripts in root of project directory
- `configure_dns_server.sh` Adds `A` records for interface, group/domain, and TLD
- `configure_web_server.sh` Adds {sub-}domain names to web server for given user/repo
- `install_jekyll.sh` Adds new user, with ssh-pub-key (git-shell access only),
 and installs to home directory of user; Jekyll, selected git-shell-command
 scripts, and initializes user named repo
- `git_shell_commands/` Scripts that maybe copied or link to Git/Jekyll users via
 `install_jekyll.sh` script


Each of the above scripts maybe run with `--help` to display select documentation within the terminal. Check the `Posts` section for usage examples.


## Note for Firejail users


Issues [1817](https://github.com/netblue30/firejail/issues/1817), [887](https://github.com/netblue30/firejail/issues/887) for Firejail shows a bit of the history of login shell options not working so great, in the case of `git` the following errors pop when Firejail is used as the *between* shell and a user with authorized access attempts to clone

```bash
    Cloning into 'test-repo'...
    fatal: unrecognized command ''git-upload-pack '"'"'git/test-repo'"'" '
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
```

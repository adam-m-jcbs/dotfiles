Here I'll collect useful coding/computing idioms, links, and such that I want to
remember and possibly eventually integrate into config files.

## Split a git repo up

Super useful, and I was able to successfully do it, so it's tested:
https://confluence.atlassian.com/bitbucket/split-a-repository-in-two-313464964.html

The key command (I added `--allow-unmatch`):
```
git filter-branch --index-filter 'git rm --cached --allow-unmatch -r lildir lildir2 <other dirs you want to recursively remove here>' -- --all
```

This will filter all of a branch's commits through the rm command, removing
everything from the given directories leaving on the history/files left.  This
filtered branch can then be used to start a new, reduced repo.

## Passwordless SSH Connections / Connecting Via Credentials

By configuring ssh to use security credentials for frequently-used systems,
you can connect more easily while still maintaining relatively strong security.

See `keygen.sh` for code to generate ssh security credentials.

Once you have these, assume we used default directories/filenames and want to
ssh from A to B w/o a password.  Then do:

```
A$ cat ~/.ssh/id_rsa.pub | ssh me@B 'cat >> .ssh/authorized_keys '
```

```
B$

```



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

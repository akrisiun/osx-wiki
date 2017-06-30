# GIT 

Hard reset for restore files (like in SVN):
```
git reset --hard HEAD 
git pull
``` 

### Working With Submodules

```
git submodule update --init --recursive
```

Mono references several external git submodules, for example a fork of Microsoft's reference source code that has been
 altered to be suitable for use with the Mono runtime.

This section describes how to use it.

An initial clone should be done recursively so all submodules will also be cloned in a single pass:

```
$ git clone --recursive git@github.com:mono/mono
Once cloned, submodules can be updated to pull down the latest changes. This can also be done after an initial non-recursive clone:

$ git submodule update --init --recursive
To pull external changes into a submodule:

$ cd <submodule>
$ git pull origin <branch>
$ cd <top-level>
$ git add <submodule>
$ git commit
By default, submodules are detached because they point to a specific commit. Use git checkout to move back to a branch before making changes:

$ cd <submodule>
$ git checkout <branch>
# work as normal; the submodule is a normal repo
$ git commit/push new changes to the repo (submodule)

$ cd <top-level>
$ git add <submodule> # this will record the new commits to the submodule
$ git commit
To switch the repo of a submodule (this should not be a common or normal thing to do at all), first edit .gitmodules to point to the new location, then:

$ git submodule sync -- <path of the submodule>
$ git submodule update --recursive
$ git checkout <desired new hash or branch>
```
The desired output diff is a change in .gitmodules to reflect the change in the remote URL, 
and a change in / where you see the desired change in the commit hash.

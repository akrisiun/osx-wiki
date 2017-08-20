### GIT - short introduction

[git-scm.com](https://git-scm.com/), 
[en.wikipedia.org/wiki/Git](https://en.wikipedia.org/wiki/Git)    
Git was created by Linus Torvalds in 2005 for development of the Linux kernel.
Git servers typically listen on TCP port 9418.

## Cleanup before merge

```
git pull
git clean  -d  -fx ""

git fetch --all
git reset --hard HEAD
```

## Use cases

```
git status
git init .

git remote -v
git fetch --all

git pull
git branch
git checkout <tmp>
git push -u origin master
git branch -D tmp

git branch dev
git checkout dev
git push -u origin dev

git branch -r
git status

git log --oneline -n9
git reflog
```

## Submodules

-> [git-submodules](git-submodules.md)

## Git operations

![Git operations](
  https://upload.wikimedia.org/wikipedia/commons/d/d8/Git_operations.svg?raw=true)

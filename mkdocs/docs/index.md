Parts:

[github.io](http://akrisiun.github.io/), <http://github.com/akrisiun/osx-wiki>,  
<http://github.com/akrisiun/dotnet-wiki>,  <http://github.com/akrisiun/profile.win10>  

macOS, Linux        | Debian, Ubuntu | Windows, .NET                            | Docker
------------------- | -------------- | ---------------------------------------- | ------------------------
[README](README.md) | [ipaddr](debian/ipaddr.md) | [re-Install](windows/README) with choco  | [swarm](docker/swarm.md)
[mysql](mysql.md)   | [eth0](debian/eth0.md)     | [powershell](windows/powershell)         | [mkdocs](docker/mkdocs.md)
[mono](mono.md)     |                            |                                          | [cloud](docker/dockercloud.md)
[brew](osx/brew.md) |                            |                                          | [docker-driver](docker/docker-driver.md)
                    |                            |                                          | [chrome](docker/chrome.md)

## Programming

mono        | php  | python
----------- | ---- | -------
mono        | php  | python

# X server, remote connect 

https://docstore.mik.ua/orelly/networking_2ndEd/ssh/ch09_03.htm
You can, however, use a general port forwarding instead. For example:

```
foo% ssh -R6010:localhost:6000 bar
bar% setenv DISPLAY bar:10

ssh -R6001:localhost:6000 192.169.1.15
export DISPLAY=:1
xcalc&
xterm&
xterm -fa 'Monospace' -fs 16 &
xrdb -merge ~/.Xresources

tuxcmd&

nslookup docker.io
```

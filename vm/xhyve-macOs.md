## Docker xhyve VM

```
brew install docker-machine-driver-xhyve  
system_profiler SPHardwareDataType

# docker-machine-driver-xhyve need root owner and uid
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

https://github.com/zchee/docker-machine-driver-xhyve
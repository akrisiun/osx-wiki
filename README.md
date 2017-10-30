## osx + linux wiki

parts:  
[eth0.md](eth0.md), 
[cntlm.md](cntlm.md), 
[apache2+webmin.md](apache2+webmin.md)  
[ftp.md](ftp.md)
[vboxManage.md](vboxManage.md)
  
GIT source versions system  
[git](git.md)
[git submodules](git-submodules.md)

.NET  
[mono.md](mono.md)
[libuv-make.cmd](libuv-make.cmd)  

Docker & cloud virtual machines  
[docker-wiki](docker-wiki.md), 
[odoo-postgres](odoo-postgres.md)  
[vm/gcloud](vm/gcloud.md)

# Linux introduction, common setup steps:

### enable ssh autostart

Script rc.local executes at each runlevel change  
1) edit /etc/rc.local file (sudo nano /etc/rc.local)  
2) just above last command (exit 0) add a line to start ssh (/etc/init.d/ssh start)  
```
sudo nano /etc/rc.local
sudo echo "/etc/init.d/ssh start" >> /etc/rc.local

sudo /etc/init.d/ssh status
```

### set path, editor

[cyberciti.biz/faq/appleosx-bash-unix-change-set-path-environment-variable](
    http://www.cyberciti.biz/faq/appleosx-bash-unix-change-set-path-environment-variable/)
.bash
```
# enviroment
env
env | grep DOCKER

echo $PATH
export PATH=
ls -l /etc/paths.d/

set
nano  ~/.bash_profile
export PS1='$(whoami)@$(hostname):$(pwd) $ '
export DISPLAY=:0
# export DOCKER_HOST=tcp://0.0.0.0:2375
unset DOCKER_HOST

# ctrl+E , ctrl+O

ip addr
ip route
less ~/.bash_history
```

### adduser addgroup chown chgrp chmod
https://en.wikipedia.org/?title=Chmod

```
adduser x staff
chgrp staff x
chmod 664 index.html
chmod 775 ./run
chgrp -R _www wwwroot
```
-R recursive

```
cp -R * /var/copy
awk 'NR > 118 && NR <= 120' <file>
awk 'NR > 118 && NR <= 120' /etc/nginx/sites-enabled/default
sudo nano /etc/nginx/sites-enabled/default
sudo nginx -t
sudo service --status-all
sudo service nginx status
```


### linux kernel and distribution version

```
uname -a
# Darwin Kernel Version 16.3.0: Thu Nov 17 20:23:58 PST 2016; root:xnu-3789.31.2~1/RELEASE_X86_64 x86_64
# (Ubuntu 14.) 3.13.0-52-generic #86-Ubuntu SMP Mon May 4 04:32:59 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

lsb_release -a
# (Debian Ubuntu) Description:	Ubuntu 14.04.5 LTS
# Codename:	trusty

cat /etc/issue
version
```

### Disk Size, mount devices
```
$ du -hs .
$ df -h
```

### Change time zone

```
sudo dpkg-reconfigure tzdata
```
### Find files
```
find /usr -iname "*libGL.so*" -exec ls -l {} \;
```

### Hello world .sh
Save the following into a file called hello.sh:
```
#!/bin/bash
echo "Hello, World!" 
echo "Knowledge is power."
```

## change mode
```
chmod +x hello.sh
./hello.sh
# recursive
chgrp -R _www wwwroot
```

### View All System Variables

[bash.cyberciti.biz/guide/Main_Page](http://bash.cyberciti.biz/guide/Main_Page), 
[guide/Variables#Commonly_Used_Shell_Variables](
    http://bash.cyberciti.biz/guide/Variables#Commonly_Used_Shell_Variables)

To see all system variables, type the following command at a console / terminal:
`set` OR `env`:  
```
ps aux | grep root
env | grep DOCKER
```

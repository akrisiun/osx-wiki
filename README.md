## osx + linux wiki

wiki parts:
[eth0.md](eth0.md), 
[cntlm.md](cntlm.md), 
[apache2+webmin.md](apache2+webmin.md)  
[ftp.md](ftp.md)
[vboxManage.md](vboxManage.md)
  
.NET 
[mono.md](mono.md)
[libuv-make.cmd](libuv-make.cmd)  
Docker
[docker-wiki.md](docker-wiki.md), 
[odoo-postgres.md](odoo-postgres.md)  

### set path, editor

http://www.cyberciti.biz/faq/appleosx-bash-unix-change-set-path-environment-variable/

.bash
```
# enviroment
env

echo $PATH
export PATH=
ls -l /etc/paths.d/

set
nano  
ctrl+E , ctrl+O
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

### linux kernel and distribution version

```
uname -a
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

http://bash.cyberciti.biz/guide/Main_Page
http://bash.cyberciti.biz/guide/Variables#Commonly_Used_Shell_Variables

To see all system variables, type the following command at a console / terminal:

set
OR
env

```
ps aux | grep root
```

## setup gcloud

sudo nano /etc/paths.d/gcloud
~/google-cloud-sdk/bin/gcloud

curl https://sdk.cloud.google.com | bash
~/google-cloud-sdk/bin/gcloud


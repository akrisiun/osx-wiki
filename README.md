## osx + linux wiki

links:
[etho.md]
[cntlm.md]
[docker-wiki.md]
[odoo-postgres.md]
[mono.md]

### set path, editor

http://www.cyberciti.biz/faq/appleosx-bash-unix-change-set-path-environment-variable/

.bash
```
echo $PATH
export PATH=
ls -l /etc/paths.d/

set
nano  
ctrl+E , ctrl+O
```

## Disk Size, mount devices

```
$ du -hs .
$ df -h
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

### mono ASP.NET

```sudo xsp4 --port 80 --root ~/public_html
```
## setup gcloud

sudo nano /etc/paths.d/gcloud
~/google-cloud-sdk/bin/gcloud

curl https://sdk.cloud.google.com | bash
~/google-cloud-sdk/bin/gcloud


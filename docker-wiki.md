### docker containers
#### https://www.docker.com/tryit/

```
docker run learn/tutorial echo "hello world"

docker pull ubuntu
docker run -it ubuntu /bin/bash

docker run -it ubuntu /bin/bash
docker run -d -p 0.0.0.0:82:80 ubuntu /bin/bash

docker commit <> an_sup
docker run -d -p 0.0.0.0:80:80 an_sup /usr/sbin/apachectl -D FOREGROUND
```

### for Hyper-V
`ssh docker@ip (tcuser)`

# docker images

```
sudo docker run -d --name ubuntu1 ubuntu 

docker run -d -p 127.0.0.1:3000:80 coreos/apache /usr/sbin/apache2ctl -D FOREGROUND

docker run -d -p 127.0.0.1:8080:80 ubuntu /usr/sbin/apachectl -D FOREGROUND
docker run -d -p 127.0.0.1:8080:80 ubuntu /usr/sbin/apachectl -D FOREGROUND

docker run -d -p 127.0.0.1:8080:80 ubuntu bash

docker start 
docker attach 

docker exec -it <container> bash
```

### Run Docker in daemon mode:
```
docker run -it  ubuntu /bin/bash
docker run -it quintenk/supervisor bash

docker run -d -p 127.0.0.1:8080:80 an_sup /usr/sbin/apachectl -D FOREGROUND
docker run -d -p 0.0.0.0:80:80 an_sup /usr/sbin/apachectl -D FOREGROUND
```

### remove dangling containers

'''
docker rmi -f $(docker images -q -a -f dangling=true)
'''

### run with ports

```
docker run -p 127.0.0.1:8069:8069 --name odoo --link db:db -t odoo

docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres
docker run -p 0.0.0.0:8069:8069 --name odoo --link db:db -t odoo

custom conf:
docker run -v /path/to/config:/etc/odoo -p 127.0.0.1:8069:8069 --name odoo --link db:db -t odoo

docker run -p 0.0.0.0:8069:8069 --name odoo1 --link db:db -t odoo
sudo docker -H 0.0.0.0:5555 -d &
```

### ubuntu

```
version
cat /etc/issue
systemctl restart docker
```

### create a file called "Dockerfile" with the following contents.

```
FROM ubuntu
RUN apt-get install ping
ENTRYPOINT ["ping"]

Create an image using the Dockerfile. Let's use a tag so we don't need to remember the hexadecimal image number.
$ docker build -t iman/ping .
```

### And then run the image in a container.

```
$ docker run iman/ping stackoverflow.com

make run-container
docker run -p 49160:8080 -d gasi/centos-node-hello
```

### Install curl:

```
sudo apt-get install curl

Docker-machine_windows-amd64.exe -d hyper-v Docker

dock -d hyper-v Docker
```
### Disk Size 

```
$ du -hs .
$ df -h
```
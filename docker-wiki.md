## docker containers
### https://www.docker.com/tryit/

```
docker run learn/tutorial echo "hello world"

docker run -t -i ubuntu /bin/bash
```

### for Hyper-V
```
ssh docker@ip (tcuser)

# docker images
sudo docker run -d --name ubuntu1 ubuntu 

docker run -d -p 127.0.0.1:3000:80 coreos/apache /usr/sbin/apache2ctl -D FOREGROUND

docker start 
docker attach 

docker exec -it <container> bash
```

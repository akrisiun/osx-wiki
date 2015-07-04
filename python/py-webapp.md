### Pyhthon sample docker webapp

```
sudo docker run -p 0.0.0.0:8081:5000 --name webapp1 --link db:db -t training/webapp
sudo docker run -p 0.0.0.0:8081:5000 --name webapp2 --link db:db -t webapp2

export TERM=linux
apt-get install -y git
apt-get install -y nano
apt-get install -y mc

cd /opt/webapp
git clone https://github.com/akrisiun/webapp.git

git config --global user.email "you@
git config --global user.name "you

pip install requests
git pull 
```

#### data container 

http://phusion.github.io/baseimage-docker/#solution

```
sudo docker pull phusion/baseimage
docker run --name wwwdata1 -v /data/wwwdata/data:/wwwdata -v /data/pgdata/data:/data -v /data/pgdata/log:/var/log/postgresql phusion/baseimage

sudo docker run -p 0.0.0.0:8081:5000 -d -P --name webapp2 --link db:db --volumes-from wwwdata1 webapp2 python app.py
sudo docker run -p 0.0.0.0:8081:5000 --name webapp2 --link db:db -t webapp2

sudo docker run -d -p 8082:5000 --name webapp3 webapp2 python app.py

sudo docker commit 5a66 webapp4
sudo docker run -d -p 8081:5000 --name webapp4 webapp4 python app.py 
```

docker run --name data-www -v /data/wwwdata/data:/wwwdata -v /data/pgdata/log:/var/log/postgresql phusion/baseimage
docker run --name PGDATA -v /data/pgdata/data:/data -v /data/pgdata/log:/var/log/postgresql phusion/baseimage:0.9.10 true
postgres-container:

docker run -d --name postgres --volumes-from PGDATA -e USER=postgres -e PASS='postgres' postgresql
$ docker run -d --name postgres --volumes-from PGDATA -e USER=postgres -e PASS='postgres' paintedfox/postgresql

ambassador-container for postgres:
$ docker run -d --name pg_ambassador --link postgres:postgres -p 5432:5432 ctlc/ambassador



 sudo docker run -d -P --name web --link db:db training/webapp python app.py

### pip for postgres

```
which pip

pip install pgcli
```

### copy files

{host} docker run -v /path/to/hostdir:/mnt $container
{host} docker exec -it $container bash
{container} cp /mnt/sourcefile /path/to/destfile

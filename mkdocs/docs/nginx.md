### nginx

```
docker pull dockerfile/nginx
```
(alternatively, you can build an image from Dockerfile: docker build -t="dockerfile/nginx" github.com/dockerfile/nginx)

###Usage
```
docker run -d -p 80:80 dockerfile/nginx
#Attach persistent/shared directories

docker run -d -p 80:80 -v <sites-enabled-dir>:/etc/nginx/conf.d -v <certs-dir>:/etc/nginx/certs -v <log-dir>:/var/log/nginx -v <html-dir>:/var/www/html dockerfile/nginx
#After few seconds, open http://<host> to see the welcome page.
	
sudo docker run -d -p 0.0.0.0:8084:80 -v /data/wwwdata/conf:/etc/nginx/conf.d -v /data/wwwdata/certs:/etc/nginx/certs -v /data/wwwdata/log:/var/log/nginx -v /data/wwwdata/html:/var/www/html nginx
sudo docker start ngnet4

nginx -t
nginx -s reload
service --status-all
	
	    access_log  /var/log/nginx/access.log  main;
	
	    sendfile        on;
	    #tcp_nopush     on;
	
	    keepalive_timeout  65;
	    #gzip  on;
	
	    include /etc/nginx/conf.d/*.conf;
		
		server {
		         listen   80;
		         server_name localhost;
		         access_log   /var/log/nginx/site.access.log;
		
		         location / {
		                 root /var/www/html/;
		                 index index.html index.htm default.aspx Default.aspx;
		                 fastcgi_index Default.aspx;
		                 fastcgi_pass 127.0.0.1:9000;
		                 include /etc/nginx/fastcgi_params;
		         }
		 }
	
	}
```
	
### /etc/nginx/fastcgi_params.

```
 fastcgi_param  PATH_INFO          "";
 fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
``` 
### mono-on-nginx with cgi .aspx

 http://www.philliphaydon.com/2013/06/setting-up-mono-on-nginx/

``` 
 apt-get install mono-complete -y
 apt-get install mono-fastcgi-server4 -y
 
 fastcgi-mono-server4 /applications=site:/:/var/www/html/ /socket=tcp:127.0.0.1:9000 &

 exec /usr/bin/
 fastcgi-mono-server4 /applications=/:/var/www/html/ /socket=tcp:127.0.0.1:9000 &			 
 
 fastcgi-mono-server4 
    --appconfigdir /etc/init.d/mono-fastcgi 
    /socket=tcp:127.0.0.1:9000 
    /logfile=/var/log/mono/fastcgi.log &			
	
	
#!/bin/bash
exec /usr/bin/fastcgi-mono-server4 /applications=/:/usr/aspnet/ /socket=tcp:127.0.0.1:9000 &
exec /usr/sbin/nginx &
exec tail -f /usr/aspnet/packages.config 
	
<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div>
    <% var test = "Hello World! Got an aspx page running on nginx!!!"; %>

    <%= test %>
    </div>
</body>
</html>
```

### node-red utility https://github.com/node-red/node-red

A visual tool for wiring the Internet of Things
```
sudo docker run -p 0.0.0.0:8081:5000 --name webapp1 --link db:db -t training/webapp
sudo docker run –p 0.0.0.0:8088:1880 -d --name nodered1  node-red
```
limitation: Invalid repository name (–p), only [a-z0-9-_.] are allowed
### https://github.com/node-red/node-red/blob/master/settings.js

```
sudo docker run cpswan/node-red:latest
sudo docker commit <> nodered

docker run --name=nodered -d -v /home/core/projekte/nodered/:/root/.node-red -p 1881:1880 cpswan/node-red

sudo docker run –p 0.0.0.0:8088:1880 --name nodered1 nodered
```
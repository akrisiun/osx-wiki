### apache2 proxy
### http://httpd.apache.org/docs/2.2/vhosts/examples.html#proxy

```
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_connect
systemctl restart apache2
systemctl reload apache2
```

ports.conf
```
<VirtualHost *:*>
ProxyPreserveHost On
ProxyPass / http://192.168.111.2/
ProxyPassReverse / http://192.168.111.2/
ServerName hostname.example.com
</VirtualHost>
```

http://doxfer.webmin.com/Webmin/Apache_Basic_Configuration


### http://pkula.blogspot.com/2015/01/production-ready-aspnet-5-mvc-vnext-on.html

Production ready ASP.NET 5 MVC (vNext) on Linux behind nginx.
What is vNext (ASP.NET 5) (.Net Core Version 1) ?

vNext is Microsoft's new, completely rewritten and open source .NET framework. They worked with MONO and Xamarin to create a completely cross platform library that can run .NET Core Apps.

 
#  Libuv

This only needs to be compiled in Linux. OSX has the correct version of this library. It is required by kestrel. Libuv enforces asynchronous and event driver style of programming. I will talk about kestrel a bit later since its installed with KVM and KRE in the next steps.

```
wget http://dist.libuv.org/dist/v1.0.0-rc1/libuv-v1.0.0-rc1.tar.gz
tar -xvf libuv-v1.0.0-rc1.tar.gz
cd libuv-v1.0.0-rc1/
./gyp_uv.py -f make -Duv_library=shared_library
make -C out
sudo cp out/Debug/lib.target/libuv.so /usr/lib/libuv.so.1.0.0-rc1
sudo ln -s libuv.so.1.0.0-rc1 /usr/lib/libuv.so.1
```
 
### Pre Install

These heading will be the order you should follow to successfully install KRE. Unfortunately the order does matter as I had some issues doing things in the incorrect order. Hopefully that will be solved once KRE matures. 
sudo apt-get update
sudo apt-get install make gyp npm
sudo apt-get install git autoconf libtool automake build-essential mono-devel gettext zip unzip
sudo apt-get install bash zsh curl
Mono

The very first thing we will need to install is the latest version of Mono. Or at least version 10.6.
You can download the source and compile yourself if you know how but you can add a reposiroty that already has the latest binaries. (These are single liners)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
then
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
Now we can run apt-get update to get the latest repo files list, install mono-complete and verify the version is one of the newest ones, preferably 1.12+.

sudo apt-get install mono-complete
mono --version
 To finish it off we need to manually add SSL certificates that are not shipped with Ubuntu by default. If you skip this then you wont be able to restore packages or use bower.
sudo certmgr -ssl -m https://go.microsoft.com
sudo certmgr -ssl -m https://nugetgallery.blob.core.windows.net
sudo certmgr -ssl -m https://nuget.org
sudo certmgr -ssl -m https://www.myget.org/F/aspnetvnext/

mozroots --import �sync
Libuv

This only needs to be compiled in Linux. OSX has the correct version of this library. It is required by kestrel. Libuv enforces asynchronous and event driver style of programming. I will talk about kestrel a bit later since its installed with KVM and KRE in the next steps.
wget http://dist.libuv.org/dist/v1.0.0-rc1/libuv-v1.0.0-rc1.tar.gz
tar -xvf libuv-v1.0.0-rc1.tar.gz
cd libuv-v1.0.0-rc1/
./gyp_uv.py -f make -Duv_library=shared_library
make -C out
sudo cp out/Debug/lib.target/libuv.so /usr/lib/libuv.so.1.0.0-rc1
sudo ln -s libuv.so.1.0.0-rc1 /usr/lib/libuv.so.1


### Going Production

Kestrel is NOT production ready. That means that you cant bind SSL certificates, do IP filtering, virtual hosts, url rewrites, etc. - and all the nice things nginx or IIS can do. My idea is to use nginx as the front end and reverse proxy to kestrel. 

Thanks to this we get the a super efficient web server that IS production ready while using ASP.NET 5 MVC  :)

nginx

Nginx is in the main repo of all the Linux and BSD distributions and only the versions might vary slightly. There is no critical version number for this to work as long as its the version that supports reverse proxy.
sudo apt-get install nginx
Now you can navigate to your IP address or domain name and you should see "Welcome to nginx!" message. That is great but we want MVC to show up there. So we need to tweak some configuration.

I start a screen (apt-get install screen) which allows me to do things in another virtual screen. If your session gets disconnected the screen will carry on working. This is very handy tool and if you are not familiar with it, you should, and it comes highly recommended. 

In the screen I will start the SampleMVC that we cloned from the ASP.NET GIT. Navigate into the directory and type "k kestrel" and the sample site will be running at http://127.0.0.1:5004 or your public IP if you are not behind NAT. To detach from the screen press CTRL + A then D.

We change a few lines in the default nginx configuration found at /etc/nginx/sites-available/default - Essentially for now we only want this in the configuration.

server {
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;
  server_name localhost;
  location /
  {
    proxy_pass http://127.0.0.1:5004;
  }
}
Save the config file and then restart nginx.

service nginx restart
We just navigated to your public IP:80 default website with nginx on it. Go back to the browser and do a full refresh. CTRL + F5 in Chrome/FF/IE. 



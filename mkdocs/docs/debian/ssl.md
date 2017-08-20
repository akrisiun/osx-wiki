
## SSHFS 

https://www.digitalocean.com/community/tutorials/how-to-use-sshfs-to-mount-remote-file-systems-over-ssh
```
sudo apt-get install sshfs -y
sudo sshfs -o allow_other,defer_permissions <host> <dir>

sudo rm -rf /Users
mkdir /Users
chown <> /Users
sudo sshfs -o allow_other <host>:/Users /Users
```

## SSL for nginx


## SSL for webmin

cat private.key your_common_name.crt > new_miniserv.pem 

/etc/nginx/ssl/miniserv.pem



```
# keyfile=/etc/webmin/miniserv.pem

ssl=1
keyfile=/etc/nginx/ssl/miniserv.pem
extracas=/etc/nginx/ssl/gd_bundle.crt
certfile=
ssl_redirect=1
ca=/etc/webmin/acl/ca.pem


no_ssl2=1
no_ssl3=1
```

extracas=/etc/webmin/DigiCertCA.crt 


### no DNS : broken solution for ping dns (

```
it seems .local address can't be access in ubuntu.
a solution is to edit /etc/nsswitch.conf and change this line :
hosts:          files mdns4_minimal [NOTFOUND=return] dns
by this :
hosts:          files dns

disabled avahi


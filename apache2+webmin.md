### apache2

#### webmin

file:
/etc/webmin/miniserv.conf
for https:

```
port=443
listen=10000
ssl=1
cipher_list_def=1
keyfile=/etc/webmin/miniserv.pem
ca=/etc/webmin/acl/ca.pem
```

#### munin

https://www.digitalocean.com/community/tutorials/how-to-install-munin-on-an-ubuntu-vps

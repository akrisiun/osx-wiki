### apache2

```
sudo apachectl graceful
```

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

.conf
```
sudo nano /etc/munin/munin.conf
dbdir /var/lib/munin
htmldir /var/cache/munin/www
logdir /var/log/munin
rundir  /var/run/munin
```

apache alias
```
sudo nano /etc/munin/apache.conf
Alias /munin /var/www/munin
<Directory /var/www/munin>
	Order allow,deny
	#Allow from localhost 127.0.0.0/8  ::1
	Allow from all
	Options None
	
```	
Next, you will need to create the directory path that you referenced in the munin.conf file and modify th
e ownership to allow munin to write to it:

```
sudo mkdir /var/www/munin
sudo chown munin:munin /var/www/munin

sudo apt-get install munin-node -y
sudo service munin-node restart
sudo apachectl graceful

sudo nano /etc/munin/munin-node.conf
allow ^123\.456\.78\.100$
```
If you have installed the Net::CIDR perl module: cidr_allow 192.0.2.0/24

port 4949
apache.conf

'''
<Directory /var/cache/munin/www>
     Order allow,deny
     Require all granted
        #Allow from localhost 127.0.0.0/8 ::1
        # Options None
     Allow from all
     Options FollowSymLinks SymLinksIfOwnerMatch
    
sudo nano -w /etc/munin/plugin-conf.d/munin-node     
'''

### http://linuxdev.dk/articles/monitoring-munin

Munin plugins actually live in /usr/share/munin/plugins, and are symlinked to in /etc/munin/plugins:
```
sudo ln -s /usr/share/munin/plugins/apache_accesses /etc/munin/plugins/apache_accesses
sudo ln -s /usr/share/munin/plugins/apache_activity /etc/munin/plugins/apache_activity
sudo rm /etc/munin/plugins/apache_activity
sudo ln -s /usr/share/munin/plugins/apache_processes /etc/munin/plugins/apache_processes
sudo ln -s /usr/share/munin/plugins/apache_volume /etc/munin/plugins/apache_volume

sudo ln -s /usr/share/munin/plugins/postgres_connections_db /etc/munin/plugins/postgres_connections_db
sudo ln -s /usr/share/munin/plugins/postgres_xlog /etc/munin/plugins/postgres_xlog

sudo nano -w /etc/munin/plugin-conf.d/munin-node
[apache_*]
env.url http://localhost:%d/server-status?auto
env.ports 80

# then:
sudo apachectl graceful
sudo /etc/init.d/munin restart
sudo /etc/init.d/munin-node restart

sudo service munin-node restart
```

#### SSH access to the node

```
~$ apt-get install autossh
~$ autossh -fN <servername/node> -L <local port>:localhost:4949
Add the node to the Munin front-end by edit munin.conf and add the node the the server tree as below.

~$ nano -w /etc/munin/munin.conf
[<servername>]
    address 127.0.0.1
    port <local port>
    use_node_name yes

To create the SSH tunnel after a reboot you can add the following command to "/etc/rc.local".
 It do require that you have a user that are allowed to ssh into the remote server without password (public/private keys).
```


### mysql for osx

```
brew install mysql --enable-debug
```

https://rtcamp.com/tutorials/mac/osx-brew-php-mysql-nginx/

### configure

Run following command to improve security of your mysql setup.
 It will present you wizard to set mysql root password among other things.
mysql_secure_installation
For workbench
Following changes will make it easy to use MySQL WorkBench

```
sudo ln -s /usr/local/Cellar/mysql/5.6.22 /usr/local/mysql
sudo ln -s /usr/local/Cellar/mysql/5.6.22/my.cnf /etc/my.cnf
# Test connection
mysql -uroot -p
```

### homebrew

http://blog.frd.mn/install-nginx-php-fpm-mysql-and-phpmyadmin-on-os-x-mavericks-using-homebrew/

Setup SSL
Create folder for our SSL certificates and private keys:
```
mkdir -p /usr/local/etc/nginx/ssl
Generate 4096bit RSA keys and the self-sign the certificates in one command:
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/
```
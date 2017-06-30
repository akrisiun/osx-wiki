### Generic https://docs.docker.com/machine/drivers/generic/

```
docker-machine create --driver generic --generic-ssh-user=docker \ 
     --generic-ip-address=192.168.0.X <name>
  
docker-machine create --driver generic --generic-ssh-user=docker --generic-ip-address=192.168.0.214 rancha214  
docker-machine create --driver generic --generic-ssh-user=docker --generic-ip-address=192.168.0.214 rancher214 
echo "192.168.0.214" > hosts
ip addr | grep eth0 
ifconfig eth0 192.168.0.215 netmask 255.255.0.0 up
 
ssh-copy-id -i /root/.ssh/id_rsa.pub -f rancher@192.168.0.214

ssh-copy-id -i /root/.ssh/id_rsa.pub 
```

### x509: certificate signed by unknown authority #8849

```
mkdir certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/dockerrepo.key -x509 \
    -days 365 -out certs/dockerrepo.crt -subj /CN=local-registry

# And then
docker-machine create --driver virtualbox default
```

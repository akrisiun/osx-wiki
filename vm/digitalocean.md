## Digital Ocean - my favorite cloud provider

https://cloud.digitalocean.com/droplets?


## Docker with digitallocean driver 

https://docs.docker.com/machine/get-started-cloud/
https://docs.docker.com/machine/examples/ocean/

```
$ 
docker-machine create --driver digitalocean --digitalocean-access-token xxxxx docker-sandbox

Environment variables and default values
CLI option	Environment variable	Default
--digitalocean-access-token	DIGITALOCEAN_ACCESS_TOKEN	-
--digitalocean-image	DIGITALOCEAN_IMAGE	ubuntu-15-10-x64
--digitalocean-region	DIGITALOCEAN_REGION	nyc3
--digitalocean-size	DIGITALOCEAN_SIZE	512mb
--digitalocean-ipv6	DIGITALOCEAN_IPV6	false
--digitalocean-private-networking	DIGITALOCEAN_PRIVATE_NETWORKING	false
--digitalocean-backups	DIGITALOCEAN_BACKUPS	false
--digitalocean-userdata	DIGITALOCEAN_USERDATA	-
--digitalocean-ssh-user	DIGITALOCEAN_SSH_USER	root
--digitalocean-ssh-port	DIGITALOCEAN_SSH_PORT	22
--digitalocean-ssh-key-fingerprint	DIGITALOCEAN_SSH_KEY_FINGERPRINT	-
```

## ssh keygen

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


```
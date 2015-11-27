### Setup steps for Ubuntu 

https://www.digitalocean.com/community/tutorials/additional-recommended-steps-for-new-ubuntu-14-04-servers

```
sudo chmod 600 /swapfile
We now have a file with the correct permissions. To tell our system to format the file for swap, we can type:

sudo mkswap /swapfile
Now, tell the system it can use the swap file by typing:

sudo swapon /swapfile
Our system is using the swap file for this session, but we need to modify a system file so that our server will do this automatically at boot. You can do this by typing:

sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'
```
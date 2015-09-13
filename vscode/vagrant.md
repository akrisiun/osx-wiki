### Windows

### mac-osx

`
vagrant init ubuntu/trusty64; vagrant up --provider virtualbox
`

trusty64 config customization: 
```
  config.vm.provision "shell", inline: <<-SHELL
     sudo apt-get update
     sudo apt-get install -y apache2 mc git nano
   SHELL
```

Cmd% button to return
default trusty64 login/password: vagrant/vagrant

ifconfig
sudo ifdown eth0
sudo ifup eth0

sudo ifconfig eth1 up
sudo nano /etc/network/interfaces


### networking eth0 interface  

```
sudo nano /etc/network/interfaces
sudo gedit /etc/network/interfaces
```
You will see this:
```
auto eth0
   iface eth0 inet static
   address 10.0.0.100
   netmask 255.255.255.0
   network 10.0.0.1
   broadcast 10.0.0.255
   gateway 46.185.128.91
```

Check open ports:
```
netstat -an -p tcp
sudo diskutil list
```

### for dhcp: Replace it with
```
auto eth0
   iface eth0 inet dhcp
```
#### Then restart networking components.
```
sudo /etc/init.d/networking restart

/sbin/ifconfig eth0 up
/sbin/ifconfig eth0 down
ip addr
sudo iptables -L -n
ifconfig eth0
```

### format fdisk

Question How to format a new hard disk - http://ubuntuforums.org/showthread.php?t=267869
```
df -h
mount | grep sda1
umount -l /dev/sda1
sudo fdisk -l /def/sda
# n - new partition
# p - primary
# 1 - partition number

# then format:
sudo mkfs.ext3 /dev/sda1

sudo mkdir /media
sudo mkdir /media/sda1
sudo mount /dev/sda1 /media/sda1
df -h 
```


### http://www.tecmint.com/ifconfig-command-examples/

```
ifconfig eth0 172.17.0.2
ifconfig eth0 netmask 255.255.255.0
```
To set the promiscuous mode, use the following command.
```
ifconfig eth0 promisc
MAC (Media Access Control) address use command with argument “hw ether“
ifconfig eth0 hw ether AA:BB:CC:DD:EE:FF
```

#### Other Networking Utilities

Tcmpdump — is an command-line packet capture and analyzer tool for monitoring network traffic.
Netstat — is an open source command line network monitoring tool that monitors incoming and outgoing network packets traffic.
Wireshark — is an open source network protocol analyzer that is used to troubleshoot network related issues.
Munin — is an web based network and system monitoring application that is used to display results in graphs using rrdtool.
Cacti — is an complete web based monitoring and graphing application for network monitoring.

#### ip for docker
https://docs.docker.com/articles/networking/#building-your-own-bridge

```
ip addr
```

Starting with Docker v.1.2.0, you can now edit
/etc/hosts, /etc/hostname and /etc/resolve.conf 
in a running container.

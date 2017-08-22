### ip addr 

<https://www.tecmint.com/ip-command-examples/>

nslookup docker.io

### eth0 address

```
ip addr show

ip addr add 192.168.1.18/20 dev eth0
ip addr add 
ip addr del 192.168.1.18/16 dev eth0
ip link set eth0 up
ip addr show
```

### route

```
ip route add 192.168.1.0/24 via 192.168.1.1 dev eth0
ip route add default via 192.168.1.1

ip route show
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1
192.168.0.0/20 dev eth0  proto kernel  scope link  src 192.168.1.18
192.168.1.0/24 via 192.168.1.1 dev eth0
192.168.99.0/24 dev eth1  proto kernel  scope link  src 192.168.99.102  metric 203
``

### HOST, Resolve DHCP

```
cat /etc/hostname
cat /etc/resolv.conf

[root@rancha18 docker]# vi /etc/network/interfaces
[root@rancha18 docker]# cat /etc/network/interfaces

auto eth0
iface eth0 inet static
address 192.168.1.18
netmask 255.255.0.0
gateway 192.168.1.1
dns-nameservers 8.8.8.8
```
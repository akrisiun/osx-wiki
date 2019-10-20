#!/bin/zsh
# docker run \
#        --it  --memory 1024mb --net host \
#        -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} \
#        --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
#       

export ip="192.168.1.9"
echo $ip

# docker run -it --net host -e DISPLAY=$(ip):0 --name wine1 --memory 1024mb  wine1
docker rm  -f wine-1
echo "docker run -d --net host -e DISPLAY=$ip:0 --name wine-1 --memory 2048mb  wine1"
docker run -d --net host -e DISPLAY=192.168.1.9:0 --name wine-1 --memory 2048mb  wine1

# docker stop wine-17
# docker commit $(id) wine17

# wget http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe 
# starting X11 tunnel:
# ssh -X -C username@hostname

# Enabling X11 tunnels: /etc/ssh/sshd_config
# X11Forwarding yes
# X11DisplayOffset 10  # this value is the default
# X11UseLocalhost yes  # this value is the default

# winecfg &
# ln -s ~/.wine/drive_c /mnt/c
# cat /etc/ssh/sshd_config | grep -v "#"
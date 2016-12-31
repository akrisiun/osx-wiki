# To run from macOS
# defaults write org.macosforge.xquartz.X11 nolisten_tcp 0  
# defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true 
# eval $(docker-machine inspect default --format={{.Driver.HostOnlyCIDR}}
# xhost +$(docker-machine ip)
# 
# docker build -t "akrisiun/wine" .
# docker run \
#        --it  --memory 1024mb --net host \
#        -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
#       
# docker run -it --net host -e DISPLAY=<ip>:0 --name wine1 --memory 1024mb akrisiun/wine

# mkdir /home/d/.wine
# export WINEPREFIX=/home/d/.wine
# export WINEARCH win32
# winetricks --unattended corefonts tahoma
# winetricks --unattended dotnet40
# wget http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe

# Wine+SSH docker image base
FROM debian:stretch
MAINTAINER Jessie Frazelle <jess@linux.com>, modified by Andrius K. <akrisiun@gmail.com>

# SSH
#   nano  --no-install-recommends 
RUN apt-get update && apt-get install -y \
    openssh-server \
    mc \
    wget ca-certificates \ 
    git \
    wine --no-install-recommends
#   mono-xsp  

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config \
    && sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config

#    && echo -e "AllowUsers git\n" >> /etc/ssh/sshd_config \
#    && echo -e "Port 22\n" >> /etc/ssh/sshd_config

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \    
    wine32 --no-install-recommends 

# not remove
# && rm -rf /var/lib/apt/lists/*

# RUN mkdir /bin
RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && mv winetricks /bin/winetricks \
    && chmod +x /bin/winetricks

ENV HOME /root
WORKDIR $HOMEENV HOME /root
WORKDIR $HOME

# private and public mapping
EXPOSE 80:8080
EXPOSE 22

# ENTRYPOINT ["start.sh"]
# CMD ["--help"]
# CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]
CMD ["ip", "addr"]

# Wine from Debian
# docker run \
#        --it  --memory 1024mb --net host \
#        -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} \
#        --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
#       
# docker run -it --net host -e DISPLAY=<ip>:0 --name wine1 --memory 1024mb akrisiun/wine
# wget http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe

# Wine+SSH docker image base
FROM debian:stretch
MAINTAINER Jessie Frazelle <jess@linux.com>, modified by Andrius K. <akrisiun@gmail.com>

# SSH
RUN apt-get update && apt-get install -y \
    openssh-server \
    mc \
    wget ca-certificates \ 
    git \
    wine --no-install-recommends

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config \
    && sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config

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

# mkdir /var/run/sshd
# /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
CMD ["ip", "addr" "| grep inet"]

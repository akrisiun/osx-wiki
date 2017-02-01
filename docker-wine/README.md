## Docker on Virtualbox defautl machine

```
docker-machine ls
unset DOCKER_HOST
eval $(docker-machine env default)
docker ps
```

## Xquartz To run from macOS

```
defaults write org.macosforge.xquartz.X11 nolisten_tcp 0  
defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true 
eval $(docker-machine inspect default --format={{.Driver.HostOnlyCIDR}}
xhost +$(docker-machine ip)
```

## Build image 

```
docker build -t "akrisiun/wine" .

docker-machine inspect default --format={{.Driver.HostOnlyCIDR}}
docker run \
       --it  --memory 1024mb --net host \
       -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} \
            --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
       
docker run -it --net host -e DISPLAY=<ip>:0 --name wine1 --memory 1024mb akrisiun/wine
docker run -it --net host -e DISPLAY=<ip>:0 --name totalcmd1 --memory 512mb \
       akrisiun/wine-totalcmd
```

### Setup

$root

```
mkdir /home/d/.wine
export WINEPREFIX=/home/d/.wine
export WINEARCH win32

winetricks --unattended corefonts tahoma
winetricks --unattended dotnet45

# totalcmd
wget http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe
```


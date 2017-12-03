## Wine 2.0.* for MacOS

setup task 
```
WINEPREFIX="$HOME/bin/wine" WINEARCH=win32 wine wineboot
brew install -y wine

winetricks --unattended corefonts tahoma
winetricks fontsmooth=rgb
# install totalcmd

cd $WINEPREFIX
pwd

cd drive_c
mkdir bin
wget http://tcmd900.s3.amazonaws.com/tcmd900ax32.exe
wine c:/bin/tcmd900ax32.exe

# start commander 
export WINEPREFIX="$HOME/bin/win
export WINEARCH=win32
export DISPLAY=:0
wine c:/bin/totalcmd/totalcmd.exe &

# Single line
WINEPREFIX=/Users/andriusk/bin/winenet45 WINEARCH=win32 wine c:/bin/totalcmd/totalcmd.exe &
```
## dotnet45

winetricks dotnet45

## Boot install.sh

echo "WINEPREFIX="$HOME/bin/winenet45" WINEARCH=win32 wine wineboot" >> wineinstall.sh

# X11 Xquartz , for $DISPLAY run from macOS

```
defaults write org.macosforge.xquartz.X11 nolisten_tcp 0  
defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
xhost +$(docker-machine ip)
xauth list
```

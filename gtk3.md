### libgtk-3-dev + gtk+3 with mono c# : https://github.com/mono/gtk-sharp

You might want to run 'apt-get -f install' to correct these.
The following packages have unmet dependencies:

```
 libgail-3-0 : Depends: libgtk-3-0 (= 3.6.0-0ubuntu3.2) but 3.6.0-0ubuntu3.1 is installed
 libgtk-3-0 : Depends: libgtk-3-common (= 3.6.0-0ubuntu3.1) but 3.6.0-0ubuntu3.2 is installed
 libgtk-3-bin : Depends: libgtk-3-0 (>= 3.6.0-0ubuntu3.2) but 3.6.0-0ubuntu3.1 is installed

sudo apt-get install libgtk-3-dev -y
sudo apt-get install libmono-addins-msbuild-cil-dev -y
```

https://github.com/mono/gtk-sharp

### Osx GTK3 with Quartz, no X11

brew
`ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`

http://balintreczey.hu/blog/beautiful-wireshark-on-os-x-using-homebrew-and-gtk3quartz/

```
# install packages we don't have to recompile to use Quartz
brew install ccache d-bus fontconfig freetype gettext glib gmp icu4c libffi libpng libtasn1 libtiff pkg-config xz hicolor-icon-theme gsettings-desktop-schemas c-ares lua portaudio geoip gnutls libgcrypt atk pixman
     
# install XQuartz from http://xquartz.macosforge.org
# Well, some builds will need the header files/libs, but you don't have to re-login
# and actually use XQuartz

# this may be needed by gtk+3 install (at least on my system with a previous installation)
brew link --overwrite gsettings-desktop-schemas
brew unlink --overwrite gsettings-desktop-schemas

# compile the rest of GTK+ 3 related libraries
brew install --build-from-source \ 
 at-spi2-core at-spi2-atk cairo harfbuzz pango gtk+3 \
 --without-x --without-x11 --with-gtk+3

brew install libxml2 
# brew install --build-from-source libcroco
git clone https://github.com/GNOME/libcroco.git
autogen.sh –disable-gtk2-engine
CROCO_CFLAGS
CROCO_LIBS

# or:
sudo port install libcroco

 
brew install --build-from-source librsvg gnome-icon-theme wireshark \ 
 --without-x --without-x11 --with-gtk+3

```

### Windows GTK3 compiled binaries:

GTK+ 3.x
GTK+ 3.6.4 is the current maintained version.

32bit: http://www.gtk.org/download/win32.php  
64bit: http://www.gtk.org/download/win64.php - still experimental (2015-08-01)  

### http://ubuntuhandbook.org/index.php/2014/07/install-corebird-ubuntu-ppa/

```
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo add-apt-repository ppa:gnome3-team/gnome3-staging
```

# 2. (For both Ubuntu 14.10 & 14.04) Add my PPA and install corebird:

```
sudo add-apt-repository ppa:ubuntuhandbook1/corebird
sudo apt-get update
sudo apt-get install corebird -y

sudo add-apt-repository ppa:gnome3-team/gnome3-staging

sudo apt-get update
sudo apt-get install libgtk-3-0 -y
```

/* Shift + mouse
The following packages were automatically installed and are no longer required:
  avahi-utils libmono-corlib2.0-cil libmono-entityframework-sqlserver6.0-cil
  libmono-entityframework6.0-cil libmono-opensystem-c4.0-cil
  libmono-sharpzip2.6-cil libmono-system2.0-cil libmono-web4.0-cil
  python-cupshelpers python-gnomekeyring python-libxml2 python-smbc
  system-config-printer-common system-config-printer-udev
Use 'apt-get autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 367 not upgraded. */

```
cd /vagrant/fcmd
git clone https://github.com/akrisiun/xwt.git xwt
```
### Or grab the .deb package directly from HERE.

?????

### Once installed, remove Gnome 3 Staging PPA via:

```
sudo add-apt-repository -r ppa:gnome3-team/gnome3-staging
```

## GAC 
Note: On Debian-based distributions, any distribution-provided Mono libraries (such as GTK#) 
are automatically installed into your mono-snapshot GAC and are available for use. This is not automatic on Red Hat-based distributions.

```
mono-snapshot
```
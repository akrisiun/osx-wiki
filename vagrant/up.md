### Vagrant up

for hyperv

```
precise64 image for vm providr hyperv

sudo aptitude update && sudo aptitude safe-upgrade 
sudo dhclient eth0
sudo aptitude install openssh-server 
```
 
## VM

```
 mkdir test_environment
 cd test_environment
 vagrant init oel57
 vagrant up
 vagrant ssh
```

https://gist.github.com/obfusk/5768197
	 
Install virtualbox and vagrant.
Download ubuntu-12.04.2-server-amd64.iso.
Create a VM precise64-flx with 360MB ram, a 40 GB dynamic VMDK hdd, and everything unnecessary (like audio and usb) disabled.
Install ubuntu on the VM in expert mode with user ubuntu and a decent password.
Create a host-only network, add a host-only network adapter to the VM (temporarily).

```
sudo aptitude update && sudo aptitude safe-upgrade
sudo dhclient eth0
sudo aptitude install openssh-server
```
	 
### Basics

for VirtualBox
```
sudo aptitude install virtualbox-guest-utils \
	virtualbox-guest-x11-
sudo aptitude update && sudo aptitude safe-upgrade

  sudo aptitude install build-essential byobu curl git grc htop \
  tree vim

sudo aptitude install ruby1.9.1-full
sudo aptitude install puppet
sudo update-alternatives --config ruby
sudo update-alternatives --config editor
```

### X11

```
 runlevel
 sudo telinit 5
 sudo apt-get install lightdm -y
``` 
set video mode (Pretty much what you already did):
```
sudo nano /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1680x1050" 
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1600x900" 
```

### Update grub: 

```
sudo update-grub
```

### lightdm Desktop manager

```
sudo apt-get install lightdm -y
sudo apt-get install ubuntu-desktop -y
sudo dpkg-reconfigure lightdm
sudo apt-get install lightdm-gtk-greeter -y
sudo apt-get install unity-2d -y

home/<>/.dmrc
sudo /usr/lib/lightdm/lightdm-set-defaults -s ubuntu-2d
sudo apt-get install tasksel

sudo add-apt-repository ppa:keks9n/monodevelop-latest
apt-get update
apt-get install mono-complete
sudo apt-get install build-essential automake checkinstall intltool git -y
sudo apt-get install mono-complete mono-addins-utils gtk-sharp2 gnome-sharp2 -y
```

### MonoDevelop ppa:keks9n/monodevelop-latest
```
sudo add-apt-repository ppa:ermshiperete/monodevelop
sudo apt-get update
sudo apt-get install monodevelop-current
```

### Reboot

```
sudo shutdown -h now
sudo reboot

uname -a
lspci -nn
sudo fdisk -l

lspci -nn
modinfo hv_vmbus
```

WARNING--look over the programs in this command carefully! This will remove all desktop/gnome programs and dependencies. Again, please look this over carefully. This will do what you asked though.
Code:
```
sudo apt-get remove ubuntu-desktop
sudo apt-get remove alacarte app-install-data-commercial apport-gtk apturl at-spi binfmt-support bluez-gnome brasero brltty-x11 capplets-data 
sudo apt-get remove cli-common compiz compiz-core compiz-fusion-plugins
```

vagrant@precise64:~$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA
vagrant@precise64:~$ sudo nano /etc/X11/xorg.conf

### for VirtualBox only

```
sudo apt-get install virtualbox-ose-guest-x11
sudo apt-get install virtualbox-guest-x11
sudo apt-get remove virtualbox-ose-guest-x11
sudo apt-get remove virtualbox-guest-x11

sudo adduser XX 
sudo adduser XX staff
sudo adduser nopasswdlogin
sudo gpasswd -a $USER nopasswdlogin 
sudo gpasswd -d $USER nopasswdlogin 
```

### Microsoft Hyper-V client drivers found in 

/drivers/staging/hv/Kconfig

Video config checks:
```
uname -a
lspci -nn
sudo fdisk -l

lspci -nn
```

### Video hv_vmbus - 00:08.0 VGA compatible controller [0300]: Microsoft Corporation Hyper-V virtual VGA [1414:5353] 

modinfo hv_vmbus

```
vagrant@precise64:/var/log$ lspci -k
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 01)
        Subsystem: Microsoft Corporation Device 0000
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
        Kernel driver in use: ata_piix
        Kernel modules: pata_acpi
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Kernel modules: i2c-piix4
00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtual VGA
        Kernel driver in use: hyperv_fb
        Kernel modules: hyperv_fb
vagrant@precise64:/var/log$
# x11 user nopasswrdlogin
sudo adduser nopasswdlogin
sudo gpasswd -a $USER nopasswdlogin 
sudo gpasswd -d $USER nopasswdlogin 
```

### Chrome (X86 chromium browser) for Linux

```
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable -y 

sudo userdel newuser
```

### Finish up by the deleting the user’s home directory:

```
sudo rm -rf /home/newuser
```
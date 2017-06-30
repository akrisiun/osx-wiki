### http://stackoverflow.com/questions/18878117/using-vagrant-to-run-virtual-machines-with-desktop-environment

```
default: vagrant:vagrant
vagrant ssh -p -- -l testuser   #replace 'testuser' 

$ sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
$ sudo VBoxClient-all
```

basic Ubuntu image working. You should be able to boot it and vagrant ssh.
Next, enable the VirtualBox display, which is off by default. Halt the VM and uncomment these lines in Vagrantfile:

```
config.vm.provider :virtualbox do |vb|
  vb.gui = true
end
Boot the VM and observe the new display window. Now you just need to install and start xfce4. Use vagrant ssh and:
sudo apt-get install xfce4
sudo startxfce4&
```

That's it, you should be landed in a xfce4 session.

Update: For a better experience, I recommend these improvements:

Don't start the GUI as root. You really want to stay the vagrant user. To do this you need to permit anyone to start the GUI: sudo vim /etc/X11/Xwrapper.config and edit it to allowed_users=anybody.
Next, install the VirtualBox guest tools before starting the GUI. This will give you a healthy screen resolution, integrated mouse, etc.

```
$ sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
$ sudo VBoxClient-all
```


### Virtual Box machines commands

```
vboxmanage modifyvm "vagtrusty_default_1439631409412_30999" --natpf1 "guestssh,tcp,,2222,,22"                               
vboxmanage list vms                                                                                                         
vboxmanage controlvm "WIN10X32" natpf1 "rpd,tcp,,3389,,3389"                                                                
VBoxManage: error: A NAT rule for this host port and this host IP already exists                                                              
VBoxManage: error: Details: code NS_ERROR_INVALID_ARG (0x80070057), component NATEngine, interface INATEngine, callee nsISupports             

VBoxManage: error: Context: "AddRedirect(Bstr(strName).raw(), proto, Bstr(strHostIp).raw(), RTStrToUInt16(strHostPort), Bstr(strGuestIp).raw()
, RTStrToUInt16(strGuestPort))" at line 574 of file VBoxManageControlVM.cpp                                                                   
vboxmanage controlvm "WIN10X32" natpf1 "rpd,tcp,,33890,,3389"                                                               
vboxmanage modifyvm "vagtrusty_default_1439631409412_30999" --natpf1 "vnc,tcp,,59001,,5900"                          vboxmanage startvm "vagtrusty_default_1439631409412_30999"                                                                  
Waiting for VM "vagtrusty_default_1439631409412_30999" to power on...                                                                         
VM "vagtrusty_default_1439631409412_30999" has been successfully started.                                            vboxmanage controlvm "vagtrusty_default_1439631409412_30999" --natpf1 "vnc,tcp,,5903,,5900"                                 
```

### VNC for ubuntu

```
sudo apt-get install -y xfce4 xfce4-goodies tightvncserver
vncserver
```
IP: 1.15:59001

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-14-04
```
vncserver -kill :1
nano ~/.vnc/xstartup
```
Insert these commands into the file so that they are performed automatically whenever you start or restart your VNC server:
```
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```


### VNC -  Virtual Network Computing

https://en.wikipedia.org/wiki/Virtual_Network_Computing

Server:
```
vncserver :0 -geometry 1920x1080 -depth 24

vncserver :0 -geometry 1600x900 -depth 24
```

### client for Windows

TightVnc viewer

<ul>
<li>
	<a href="http://www.tightvnc.com/download/2.7.10/tightvnc-2.7.10-setup-64bit.msi" 
	>
	<b>Installer for Windows (64-bit)</b></a>
	(2,367,488 bytes)
</li>
<li style="margin-top: 0.5em; margin-bottom: 0.5em;">
	<a href="http://www.tightvnc.com/download/2.7.10/tightvnc-2.7.10-setup-32bit.msi" >

	<b>Installer for Windows (32-bit)</b></a>
	(2,105,344 bytes)
</li></ul>

### VNC server for OS-X

http://apple.stackexchange.com/questions/30238/how-to-enable-os-x-screen-sharing-vnc-through-ssh

Putty is a good SSH client for Windows.
1) SSH into your remote OS X machine with an administrator�s log in and password.
2) Enable Remote Desktop (a.k.a. Screen Sharing, a.k.a. VNC) with this command:

```
sudo  /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -clientopts -setvnclegacy -vnclegacy yes -clientopts -setvncpw -vncpw mypasswd -restart -agent -privs -all
```
http://ss64.com/osx/kickstart.html

3) Login using a VNC client. As I mentioned, TightVNC worked for me; for some reason, RealVNC and UltraVNC didn�t.

4) When you are done, turn of screen sharing using your SSH session:
```
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off
```

### client for OS-X

VNC may be tunnelled over an SSH or VPN connection

### ssh over 443 port

Since https is a "client speaks first" protocol and ssh is a "server speaks first" protocol, you can actually have them both active on the same port with a multiplexer like this: http://www.rutschle.net/tech/sslh.shtml
Pretty common around here. Very often people configure sshd to listen on 22 and 443.

your pocket device connects to wifi, and then establishes a tunnel to your trusted machine using port 53 (i.e. if the trusted machine has an IP of 1.2.3.4, then you ssh -p53 1.2.3.4/my/proxy 

ssh -p443 192.168.1.15
ssh -p22 192.168.1.15

I've been looking at using a WebSocket proxy (e.g. https://npmjs.org/package/ws-tcp-bridge), which might be able to get around that.
permalinksaveparentgive gold
In a work environment, sure, what pisses me off are campus or hotel networks that block everything but http and https. At that point you may as well not offer a network at all.
permalinksaveparentgive gold
The average user won't use anything besides 80 or 443. I once got into a discussion on one of the other subreddits mentioning that I didn't really like subscribing to a service that included ads. You would be amazed at how many peo


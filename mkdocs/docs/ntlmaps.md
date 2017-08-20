## ntlmaps

ntlmaps is python powered proxy to access Internet thrown ISA Windows domain proxy.
Alternative for cntlm.
GitHub repo: https://github.com/heupel/ntlmaps  
My fork:
```
git clone https://github.com/akrisiun/ntlmaps ntlmaps
```

### **Usage:** Install NTLMAPS
 
http://wingloon.com/2010/08/16/install-and-configure-ntlmaps-to-access-isa-server/
 
Run the command below to extract downloaded file to a target directory:   
`tar xvfz ntlmaps-0.9.9.0.1.tar.gz -C /usr/local/bin
`
Run the command below to create a symbolic link:  
`ln -s /usr/local/bin/ntlmaps-0.9.9.0.1 /usr/local/bin/ntlmaps
`
Run the command below to backup the NTLMAPS configuration file:  
`cp -a /usr/local/bin/ntlmaps/server.cfg /usr/local/bin/ntlmaps/server.cfg-default
`
Run the command below to edit the NTLMAPS configuration file:  
`nano /usr/local/bin/ntlmaps/server.cfg
`

### Configure NTLMAPS
By default NTLMAPS listen on port 5865, you can change it to any port you preferred. I leave it as default. Remember to save the configuration file after modifying it as below (an example only): �

```
LISTEN_PORT:5865
PARENT_PROXY:your.isa.server.name
PARENT_PROXY_PORT:your.isa.server.port
ALLOW_EXTERNAL_CLIENTS:1
FRIENDLY_IPS:your.client.ip1 your.client.ip2
NT_HOSTNAME:your.ntlmaps.server.name
NT_DOMAIN:your.domain
USER:your.nt.username
PASSWORD:your.nt.password
LM_PART:1
NT_PART:1
NTLM_FLAGS: 07820000
```

### Start NTLMAPS

Run the command below to start NTLMAPS:  
`/usr/local/bin/ntlmaps/main.py -c /usr/local/bin/ntlmaps/server.cfg &
`

System Wide Configuration
You can setup the proxy environment in /etc/profile as global variable as below (tested with curl,elinks,lynx and wget):  
export http_proxy=http://127.0.0.1:5865

GUI Web Browser Configuration
You can use the following information to configure in your GUI web browser: �
```
Proxy IP address: 127.0.0.1
Proxy IP address: 5865
```
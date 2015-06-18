### Configure Cntlm

```
rpm -ivh cntlm-0.92.3-1.x86_64.rpm
```
Run the command below to edit the Cntlm configuration file after Cntlm installed: �

```
vi /etc/cntlm.conf
```

Now modify the below and save the configuration file after modifying it (below is an example only): –

Username your.nt.username
Domain your.domain
Proxy your.isa.server.name:your.isa.server.port
Listen 3128
Next run the command below to generate the password hash: –

### 

cntlm -H -c /etc/cntlm.conf

Once the password has is created, copy the PassNTLMv2 line and paste it after “Domain” line like below: –
```
Username your.nt.username
Domain your.domain
PassNTLMv2 your.password.hash
Proxy your.isa.server.name:your.isa.server.port
Listen 3128
Start Cntlm
```
Run the command below to start NTLMAPS: –

### service cntlmd start
System Wide Configuration
You can setup the proxy environment in /etc/profile as global variable as below (tested with curl, elinks, lynx, wget & yum): –

```
export http_proxy=http://127.0.0.1:3128
```
### Ubuntu ftp server

```
sudo apt-get install vsftpd
sudo nano /etc/vsftpd.conf
```
Edit or uncomment the following lines to secure VSFTPD
```
Anonymous_enable=NO
Local_enable=YES
Write_enable=YES
Ascii_upload_enable=YES
Ascii_download_enable=YES
```

### Restart
```
sudo /etc/init.d/vsftpd restart
```

### OSX ftp, launchctl 

http://www.real-world-systems.com/docs/launchctl.1.html
```
sudo launchctl stop com.apple.ftpd

sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
sudo launchctl list | grep ftp
sudo launchctl start com.apple.ftpd

sudo nano /etc/ftpusers
#TODO
#Ok, found it. The update seems to have reset the FTP access rights in com.apple.access_ftp.
#dseditgroup -o edit -u ((admin name)) -a ((scanner account)) com.apple.access_ftp

sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist
sudo launchctl load /System/Library/LaunchDaemons/ftp.plist
sudo launchctl unload /System/Library/LaunchDaemons/ftp.plist

# The config file is /etc/ftpd.conf, mine looks like this:
sudo nano /etc/ftpd.conf

# match umask from Mac OS X Server ftpd
umask all 022
chroot GUEST /Users/linickx/ftp
modify guest off
umask  guest 0707
upload guest on
```

As you can see, I have changed the home directory of my anonymous user to a folder called ftp inside my home directory.

Now, there's some special security stuff you can do to that folder, see man ftpd for full details, but this should do you as a minimun

### sftp client

`sftp username@remote_hostname_or_IP`

Available commands:
```
ls -la
lpwd
lls
bye                                Quit sftp


get remoteFile localFile
# The "get" command also takes some option flags. For instance, we can copy a directory and all of its contents by specifying the recursive option:
get -r someDirectory
# We can tell SFTP to maintain the appropriate permissions and access times by using the "-P" or "-p" flag:
get -Pr someDirectory

put <file>
put -r localDirectory

df -h
cd path                            Change remote directory to 'path'
chgrp grp path                     Change group of file 'path' to 'grp'
chmod mode path                    Change permissions of file 'path' to 'mode'
chown own path                     Change owner of file 'path' to 'own'
df [-hi] [path]                    Display statistics for current directory or
                                   filesystem containing 'path'
exit                               Quit sftp
get [-Ppr] remote [local]          Download file
help                               Display this help text
lcd path                           Change local directory to 'path'
```
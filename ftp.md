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
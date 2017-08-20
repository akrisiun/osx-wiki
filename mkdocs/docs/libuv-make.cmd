## libuv for vNext

Step: (Optional if Libuv is already present) Setup Libuv package on Linux [Reference ASP.NET github home repo docs]:

```
curl -sSL https://github.com/libuv/libuv/archive/v1.5.0.tar.gz | sudo tar zxfv - -C /usr/local/src
cd /usr/local/src/libuv-1.5.0
sudo sh autogen.sh
sudo ./configure
sudo make
sudo make install
sudo rm -rf /usr/local/src/libuv-1.5.0 && cd ~/
sudo ldconfig
```


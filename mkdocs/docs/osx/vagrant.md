Vagrant.configure("2") do |config|
  config.vm.network "public_network", ip: "192.168.0.17"

  # default router
  config.vm.provision "shell",
    run: "always",
    inline: "route add default gw 192.168.0.1"

    
    docker-machine create      --driver "generic"       --generic-ip-address 192.168.1.20 --generic-ssh-user andriusk  host20
    
    sudo apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common -y
    sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu    $(lsb_release -cs) stable"

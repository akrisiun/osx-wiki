https://www.raywenderlich.com/122189/introduction-to-open-source-swift-on-linux

vagrant-swift. Inside that directory, create a file named Vagrantfile and add to it the lines below:
Vagrant.configure(2) do |config|
  ## 1
  config.vm.box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
 
config.vm.provision "shell", inline: <<-SHELL
    ## 2
    sudo apt-get --assume-yes install clang libicu-dev
    ## 3
    curl -O https://swift.org/builds/development/ubuntu1404/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz
    ## 4
    tar zxf swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04.tar.gz
    ## 5 
    sudo chown -R vagrant:vagrant swift-*
    ## 6
    echo "export PATH=/home/vagrant/swift-DEVELOPMENT-SNAPSHOT-2016-04-12-a-ubuntu14.04/usr/bin:\"${PATH}\"" >> .profile
    echo "Swift has successfully installed on Linux"
  SHELL
end

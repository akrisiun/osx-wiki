# Jenkins build server 

http://blog.bekijkhet.com/2013/01/create-mono-c-buildserver-using-jenkins.html

```
Install Git

sudo apt-get update
sudo apt-get install git
Install Mono

sudo apt-get update
sudo apt-get install mono-complete
Install Jenkins

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

Now it is time to start jenkins for the first time. Open a browser and browse to http://build01:8080
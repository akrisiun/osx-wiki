##osx-wiki

### set path
http://www.cyberciti.biz/faq/appleosx-bash-unix-change-set-path-environment-variable/

.bash
echo $PATH
ls -l /etc/paths.d/

set
nano  
 ctrl+E , ctrl+O

### Hello world .sh
Save the following into a file called hello.sh:

#!/bin/bash
echo "Hello, World!" 
echo "Knowledge is power."

chmod +x hello.sh
./hello.sh

###View All System Variables

http://bash.cyberciti.biz/guide/Main_Page
http://bash.cyberciti.biz/guide/Variables#Commonly_Used_Shell_Variables

To see all system variables, type the following command at a console / terminal:

set
OR
env

##setup gcloud

sudo nano /etc/paths.d/gcloud
~/google-cloud-sdk/bin/gcloud

curl https://sdk.cloud.google.com | bash
~/google-cloud-sdk/bin/gcloud

### MVC mono

visualstudio.com/DefaultCollection/_git/dxBuild
visualstudio.com/DefaultCollection/_git/SntxPrekesWeb
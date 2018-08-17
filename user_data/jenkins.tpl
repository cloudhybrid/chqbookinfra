#!/bin/bash
sudo yum install git wget -y
git clone https://gist.github.com/03aedd59f9754a3cd1c8805f5b9ec46d.git /home/ec2-user/setup
chmod +x /home/ec2-user/setup/setupManagment.sh

bash /home/ec2-user/setup/setupManagment.sh

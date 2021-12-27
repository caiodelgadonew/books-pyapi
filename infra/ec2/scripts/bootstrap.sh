#!/bin/bash

# Install Amazon ssm-agent
yum update -y 
yum install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl start amazon-ssm-agent
systemctl enable amazon-ssm-agent

# Install  Docker and Docker-Compose 
amazon-linux-extras install docker
yum install docker
systemctl start docker
systemctl enable docker
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone Repo and run application
yum install git -y
mkdir -p /app/book-pyapi
git clone https://github.com/caiodelgadonew/book-pyapi.git /app/book-pyapi
cd /app/book-pyapi
docker image build -t books-pyapi .
/usr/local/bin/docker-compose -f docker-compose-mysql.yml up -d 

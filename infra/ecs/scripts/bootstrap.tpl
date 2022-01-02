#!/bin/bash

yum update -y 
amazon-linux-extras disable docker
amazon-linux-extras install -y ecs

echo "ECS_CLUSTER=${CLUSTER_NAME}" > /etc/ecs/ecs.config

systemctl start amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start docker
systemctl enable docker

echo "[!] Init Process Done [!]"

/usr/libexec/amazon-ecs-init pre-start
/usr/libexec/amazon-ecs-init start &
sleep 10
echo "[!] ECS Agent started [!]"

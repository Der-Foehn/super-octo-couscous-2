#!/bin/bash
sed -i -e 's/PermitRootLogin no/PermitRootLogin yes/
s/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

sudo service sshd restart
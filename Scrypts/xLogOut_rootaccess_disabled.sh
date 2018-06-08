#!/bin/bash
sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/
s/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

sudo service sshd restart
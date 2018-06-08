## Get your public IP ##
_myip="$(/bin/curl ifconfig.me)"
_cmd1="/bin/sed -i 's/^acl verizonfios.*/acl verizonfios src ${_myip}/' /etc/squid/squid.conf"
_cmd2="/usr/sbin/squid -k reconfigure"

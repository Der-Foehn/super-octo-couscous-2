
cd
clear

# Do you want to install Fail2ban?
read -e -p "Install Fail2ban? (Recommended) [Y/n] : " install_fail2ban

# Do you want to install UFW?
read -e -p "Install UFW? (Recommended) [Y/n] : " install_ufw

# Do you want to setup a Stratum-Server?
read -e -p "Do you want to setup a Stratum-Server? [Y/n] : " install_stratum

# Do you want to setup a Pool-Server (Website, Database?
read -e -p "Do you want to setup a Pool-Server (Website, Database? [Y/n] : " install_pool

# Add swap if needed..
if [[ ("$add_swap" == "y" || "$add_swap" == "Y" || "$add_swap" == "") ]]; then
    if [ ! -f /swapfile ]; then
        echo && echo "Adding swap space..."
        sleep 3
        sudo fallocate -l $swap_size /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
        sudo sysctl vm.swappiness=10
        sudo sysctl vm.vfs_cache_pressure=50
        echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
        echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
    else
        echo && echo "WARNING: Swap file detected, skipping add swap!"
        sleep 3
    fi
fi

# Update system 
echo "Upgrading system and install initial dependencies"
sleep 3
sudo apt-get -y update
sudo apt-get -y upgrade

# Remove group writeable rights (problem on scaleways server)
echo && echo "remove groupe writeable rights (scaleways server)"
sleep 1 
sudo -i;
chmod 755 /etc /lib /usr;

# Install required packages for compiling wallets etc.
echo && echo "Installing base packages..."
sleep 3
sudo apt-get -y install \
build-essential \
libtool \
autotools-dev \
automake \
unzip \
pkg-config \
libssl-dev \
bsdmainutils \
software-properties-common \
libzmq3-dev \
libevent-dev \
libboost-dev \
libboost-chrono-dev \
libboost-filesystem-dev \
libboost-program-options-dev \
libboost-system-dev \
libboost-test-dev \
libboost-thread-dev \
libdb4.8-dev \
libdb4.8++-dev \
libminiupnpc-dev \
python-virtualenv 


# Install fail2ban if wanted
if [[ ("$install_fail2ban" == "y" || "$install_fail2ban" == "Y" || "$install_fail2ban" == "") ]]; then
    echo && echo "Installing fail2ban..."
    sleep 3
    sudo apt-get -y install fail2ban
    sudo service fail2ban restart 
fi

# Install ufw if wanted
if [[ ("$install_ufw" == "y" || "$install_ufw" == "Y" || "$install_ufw" == "") ]]; then
echo "install UFW"
sleep 1
sudo apt-get install ufw;
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
fi
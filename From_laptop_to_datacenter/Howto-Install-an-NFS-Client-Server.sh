####################
# On the server

# Commands to be executed by root user
sudo su -
mkdir /data
chmod 755 /data
touch /data/nfs-test
yum -y install nfs-utils nano

nano /etc/exports
      /data  <destination_host IP - USE the private IP>(rw,sync,no_wdelay)

cat /etc/exports  # verify your editing

# now we start the nfs server
systemctl enable --now rpcbind nfs-server

# Verify the server is working properly
systemctl status nfs-server

exportfs   # verify what we are exporting to whom

# In case we have firewall active
firewall-cmd --add-service=nfs --permanent 
firewall-cmd --reload 

####################
# On the client

# Commands to be executed by root user 
mkdir /data_mounted
yum -y install nfs-utils
mount -t nfs <your_server_ip>:/data /data_mounted
ll /data_mounted/
cat /etc/mtab | grep data_mounted
umount /data_mounted

# in case we want to automount the FS at boot time
nano /etc/fstab
# add the following line at the end of the file
<SERVER_PRIVATE_IP>:/data /data_mounted   nfs defaults        0 0

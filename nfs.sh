#NFS Server configuration 198.168.109.130
sudo yum search nfs-utils
sudo yum install nfs-utils -y
sudo systemctl start nfs-server
sudo systemctl status  nfs-server
rpcinfo -p | grep -i nfs
sudo mkdir -p /mnt/nfs_shares/docs
sudo chown -R nobody: /mnt/nfs_shares/docs
sudo chmod -R 777 /mnt/nfs_shares/docs/
sudo systemctl restart nfs-utlis.service
sudo systemctl restart nfs-server

#Edit exports file | you can add it manually or you can echo to the file
#Automate by echoing to the file make sure to add your on subnet or single host see example below
sudo echo "/mnt/nfs_shares/docs   <your IP or your ipsubnet>(rw,sync,no_all_squash,root_squash)" >> /etc/exports
#manual configuration
sudo vi /etc/exports
#Add the following commented out line to the exports file. First line is an example second is your config.
#/mnt/nfs_shares/docs   192.168.109.0/24(rw,sync,no_all_squash,root_squash)
#/mnt/nfs_shares/docs   <your IP or your ipsubnet>(rw,sync,no_all_squash,root_squash)


#Verify export file configuration
sudo exportfs -arv
chkconfig --list | grep nfs

#Allow the following ports on the public firewall 
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --permanent --add-service=rpc-bind
sudo firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --reload

#Create a test file for the client to verify.
sudo touch /mnt/nfs_shares/docs/file_nfs_test.txt

#Do this after the client 
ls -l /mnt/nfs_shares/docs/



#Client configuration 192.168.109.138
sudo yum install nfs-utils nfs4-acl-tools -y
sudo showmount -e 192.168.109.130
sudo mkdir -p /mnt/client_share
sudo mount -t nfs 192.168.109.130:/mnt/nfs_shares/docs /mnt/client_share
sudo mount | grep -i nfs
#persist mount point by adding line to fstab
sudo echo "192.168.109.130:/mnt/nfs_shares/docs  /mnt/client_share  nfs  defaults  0  0" >> /etc/fstab
#testing the configuration NFS server should see these files
sudo touch /mnt/client_share/client_nfs_file.txt


#Use this command to add all of you history to a text file by redirection to STOUT to a file
history | cut -c 8- > yourconfig.txt

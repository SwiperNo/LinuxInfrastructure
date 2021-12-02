sudo yum  install samba samba-common samba-client
cd /etc/samba/
sudo mv smb.conf smb.conf.bak
sudo cp smb.conf.bak smb.conf
sudo mkdir - /srv/samba/shared
cd /srv/
sudo mkdir samba
cd samba/
sudo mkdir - /srv/samba/shared
sudo chmod -R 0755 /srv/samba/shared/
sudo chmod -R nobody:nobody /srv/samba/shared
sudo groupadd samba
sudo usermod -aG samba samba1
sudo chmod -R samba1:samba /srv/samba/shared
sudo chown -R nobody:nobody /srv/samba/shared/
sudo chcon -t samba_share_t /srv/samba/shared
sudo vi /etc/samba/smb.conf
sudo testparm
sudo firewall-cmd --add-service=samba --zone=public --permanent
sudo firewall-cmd --reload
sudo systemctl start smb
sudo systemctl enable smb
sudo sysctl stat smb
sudo systemctl status smb

sudo vi /etc/resolv.conf


sudo nslookup fs1
sudo nslookup 192.168.109.139
ping dns1.swipe.com

cd /srv/samba/
sudo mkdir test

sudo vi /etc/samba/smb.conf
sudo testparm

sudo systemctl start nmb
sudo systemctl enable nmb
sudo systemctl status nmb
ip a | grep -i inet


cd /srv/samba/shared/
mkdir data
sudo mkdir data
touch test.txt
sudo touch test.txt


sudo groupadd samba_secure
sudo useradd -g samba_secure linuxuser
sudo mkdir -p /srv/samba/secure_share
sudo chmod -R 0770 /srv/samba/secure_share/




sudo chcon -t samba_share_r /srv/samba/secure_share
sudo semanage fcontext -l | grep samba_share
sudo semanage fcontext -l | grep samba*
sudo chcon -t samba_secrets_t /srv/samba/secure_share



sudo chown -R root:samba_secure /srv/samba/secure_share/

sudo smbpasswd -a linuxuser
sudo vi /etc/samba/smb.conf
testparm

sudo systemctl restart samba
sudo systemctl restart smb
sudo systemctl restart nmb
sudo systemctl status smb



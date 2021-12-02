### Install Syslog server
sudo yum update
sudo yum install rsyslog

#Make a back up of the configuration file
sudo cp /etc/rsyslog.conf /etc/rsyslog.conf.bk


#Edit configuration file 
sudo vi /etc/rsyslog.conf
sudo systemctl status rsyslog


#Add Firewall Rules
sudo firewall-cmd --add-port=514/tcp --zone=public --permanent
sudo firewall-cmd --reload


#Restart after configuration and enable
sudo systemctl restart rsyslog
sudo systemctl enable rsyslog

#Verify Syslog is running 
sudo netstat -pnltu | grep -i 514

#Verify Syslog messages.
sudo tail -f /var/log/messages

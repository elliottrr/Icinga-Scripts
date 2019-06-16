#!/bin/bash

echo "Installing required packages..."
rpm --import ./RPM-GPG-KEY-EPEL-7
yum -y install sysstat nrpe nagios-plugins-all vim

echo "Copying files..."
cp ./check_meminfo /usr/lib64/nagios/plugins/
cp ./check_nfs_mounts.sh /usr/lib64/nagios/plugins/
cp ./check_uptime.pl /usr/lib64/nagios/plugins/
cp ./check_vm_balloon /usr/lib64/nagios/plugins/
cp ./check_mpstat.pl /usr/lib64/nagios/plugins/

chmod 755 /usr/lib64/nagios/plugins/check_meminfo
chmod 755 /usr/lib64/nagios/plugins/check_nfs_mounts.sh
chmod 755 /usr/lib64/nagios/plugins/check_uptime.pl
chmod 755 /usr/lib64/nagios/plugins/check_vm_balloon
chmod 755 /usr/lib64/nagios/plugins/check_mpstat.pl

echo "Correcting SELinux Contexts..."
chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_meminfo
chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_nfs_mounts.sh
chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_uptime.pl
chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_vm_balloon
chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_mpstat.pl


echo "Adding lines to /etc/nagios/nrpe..."
sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1,glados.services.ou.edu,chell.services.ou.edu/' /etc/nagios/nrpe.cfg
sed -i 's/check_procs -w 150 -c 200/check_procs -w 500 -c 750/' /etc/nagios/nrpe.cfg
#echo "allowed_hosts=127.0.0.1,glados.services.ou.edu,chell.services.ou.edu" >> /etc/nagios/nrpe.cfg
echo "" >> /etc/nagios/nrpe.cfg
echo "command[check_disk]=/usr/lib64/nagios/plugins/check_disk -w 10% -c 5% -X nfs -x /backup" >> /etc/nagios/nrpe.cfg
echo "" >> /etc/nagios/nrpe.cfg

echo "" >> /etc/nagios/nrpe.cfg
echo "# Uptime Check" >> /etc/nagios/nrpe.cfg
echo "command[check_uptime]=/usr/lib64/nagios/plugins/check_uptime.pl 1200 600" >> /etc/nagios/nrpe.cfg

echo "" >> /etc/nagios/nrpe.cfg
echo "# Memory Information" >> /etc/nagios/nrpe.cfg
echo "command[check_meminfo_real]=/usr/lib64/nagios/plugins/check_meminfo -real" >> /etc/nagios/nrpe.cfg
echo "command[check_meminfo_swap]=/usr/lib64/nagios/plugins/check_meminfo -swap" >> /etc/nagios/nrpe.cfg
echo "command[check_meminfo_active]=/usr/lib64/nagios/plugins/check_meminfo -active" >> /etc/nagios/nrpe.cfg

echo "" >> /etc/nagios/nrpe.cfg
echo "# NFS Checks" >> /etc/nagios/nrpe.cfg
echo "#command[check_nfs_<mntpnt>]=/usr/lib64/nagios/plugins/check_nfs_mounts.sh -ro <path-to-mntpnt>" >> /etc/nagios/nrpe.cfg
#echo "command[check_nfs_psreports]=/usr/lib64/nagios/plugins/check_nfs_mounts.sh -ro /opt/psreports" >> /etc/nagios/nrpe.cfg
#echo "command[check_nfs_backup]=/usr/lib64/nagios/plugins/check_nfs_mounts.sh -ro /backup" >> /etc/nagios/nrpe.cfg

#echo "" >> /etc/nagios/nrpe.cfg
#echo "# Check Oracle Listener" >> /etc/nagios/nrpe.cfg
#echo "command[check_tcp_ora_listener]=/usr/lib64/nagios/plugins/check_tcp -H 10.26.195.18 -v -p 1521 -r crit -w 5 -c 10" >> /etc/nagios/nrpe.cfg

echo "" >> /etc/nagios/nrpe.cfg
echo "# Memory Balloon" >> /etc/nagios/nrpe.cfg
echo "command[check_balloon]=/usr/lib64/nagios/plugins/check_vm_balloon 1024 2048" >> /etc/nagios/nrpe.cfg

echo "" >> /etc/nagios/nrpe.cfg
echo "# CPU mpstat statistics" >> /etc/nagios/nrpe.cfg
echo "command[check_mpstat]=/usr/lib64/nagios/plugins/check_mpstat.pl" >> /etc/nagios/nrpe.cfg

echo "Starting NRPE..."
#chkconfig nrpe on
#service nrpe start
systemctl enable nrpe
systemctl start nrpe

echo "Done."

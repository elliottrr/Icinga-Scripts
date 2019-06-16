#!/bin/bash

cp ./check_uptime.pl /usr/lib64/nagios/plugins/

chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_uptime.pl

echo "" >> /etc/nagios/nrpe.cfg
echo "# Uptime Check" >> /etc/nagios/nrpe.cfg
echo "command[check_uptime]=/usr/lib64/nagios/plugins/check_uptime.pl 1200 600" >> /etc/nagios/nrpe.cfg

sudo /sbin/service nrpe restart

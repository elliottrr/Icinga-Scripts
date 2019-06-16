#!/bin/bash

cp ./check_IOlatency.pl /usr/lib64/nagios/plugins/

chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_IOlatency.pl

echo "" >> /etc/nagios/nrpe.cfg
echo "# Device IO statistics" >> /etc/nagios/nrpe.cfg
echo "command[check_IOlatency]=/usr/lib64/nagios/plugins/check_IOlatency.pl" >> /etc/nagios/nrpe.cfg

sudo /sbin/service nrpe restart

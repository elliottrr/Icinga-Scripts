#!/bin/bash

cp ./check_mpstat.pl /usr/lib64/nagios/plugins/

chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_mpstat.pl

echo "" >> /etc/nagios/nrpe.cfg
echo "# CPU mpstat statistics" >> /etc/nagios/nrpe.cfg
echo "command[check_mpstat]=/usr/lib64/nagios/plugins/check_mpstat.pl" >> /etc/nagios/nrpe.cfg

sudo /sbin/service nrpe restart

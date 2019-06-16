#!/bin/bash

cp ./check_vm_balloon /usr/lib64/nagios/plugins/

chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_vm_balloon

echo "" >> /etc/nagios/nrpe.cfg
echo "# VM Balloon Check" >> /etc/nagios/nrpe.cfg
echo "command[check_balloon]=/usr/lib64/nagios/plugins/check_vm_balloon" >> /etc/nagios/nrpe.cfg

sudo /sbin/service nrpe restart

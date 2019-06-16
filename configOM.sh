#!/bin/bash

cp ./check_openmanage /usr/lib64/nagios/plugins/

chcon system_u:object_r:nagios_unconfined_plugin_exec_t:s0 /usr/lib64/nagios/plugins/check_openmanage

echo "" >> /etc/nagios/nrpe.cfg
echo "# Check Dell hardware" >> /etc/nagios/nrpe.cfg
echo "command[check_dell_sensors]=/usr/lib64/nagios/plugins/check_openmanage --no-storage" >> /etc/nagios/nrpe.cfg

/sbin/service nrpe restart

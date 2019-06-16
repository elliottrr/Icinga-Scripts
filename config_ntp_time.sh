#!/bin/bash

#yum -y install nrpe nagios-plugins-ntp

echo "" >> /etc/nagios/nrpe.cfg
echo "# NTP Time Check" >> /etc/nagios/nrpe.cfg
echo "command[check_time_drift1]=/usr/lib64/nagios/plugins/check_ntp_time -H ntp01.ou.edu -w 0.5 -c 1.0" >> /etc/nagios/nrpe.cfg
echo "command[check_time_drift2]=/usr/lib64/nagios/plugins/check_ntp_time -H ntp02.ou.edu -w 0.5 -c 1.0" >> /etc/nagios/nrpe.cfg

sudo /sbin/service nrpe restart

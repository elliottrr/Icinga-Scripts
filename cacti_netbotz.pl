#!/usr/bin/perl

use strict;

# Check MemInfo
# This script retrieves SNMP OIDs from devices located on VLAN 900 via the NRPE
# .
# Usage: cacti_netbotz.pl <IP of device> <OID> <Community>
#
# Example cacti_netbotz.pl 1.2.3.4 .1.3.6.1.4.1.5528.100.4.1.1.1.9.1095346743 public3

my $psmtpIP = "<SSH-NRPE-relay-host>";

# /usr/lib64/nagios/plugins/check_nrpe -H <SSH-NRPE-relay-host> -c check_snmp -a 85 90 10.255.1.245 public3 .1.3.6.1.4.1.5528.100.4.1.2.1.2.1095346743 'Temp:' 'F'
my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $psmtpIP -c check_snmp -a 998 999 $ARGV[0] $ARGV[2] $ARGV[1] 'val1' 'XXX'`;
my @values = split('\| ', $dataIn);
my $dataOut = $values[1];
$dataOut =~ s/=/:/g;
print "$dataOut";

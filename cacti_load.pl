#!/usr/bin/perl

use strict;

# Check MemInfo
# This script translates the output format from check_meminfo_[total|swap|active]
# into a format that Cacti can understand
# Usage: cacto_meminfo.pl <ipaddr> <call_name>
#
# Example cacti_meminfo.pl 127.0.0.1 check_meminfo_real

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_load`;
$dataIn =~ s/\|/-/g;
$dataIn =~ s/ load average per CPU: //g;
my @values = split("-", $dataIn);
$values[1] =~ s/ load average: //;
my @loads = split(", ", $values[1]);
print "1min:$loads[0] 5min:$loads[1] 15min:$loads[2]";

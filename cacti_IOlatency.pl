#!/usr/bin/perl

use strict;

# Check MemInfo
# This script translates the output format from check_meminfo_[total|swap|active]
# into a format that Cacti can understand
# Usage: cacto_meminfo.pl <ipaddr> <call_name>
#
# Example cacti_meminfo.pl 127.0.0.1 check_meminfo_real

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 30 -H $ARGV[0] -c check_IOlatency`;
print "$dataIn";

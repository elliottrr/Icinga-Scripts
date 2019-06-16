#!/usr/bin/perl

use strict;

# Check CPU MPstat
# Example cacti_cpustat.pl 127.0.0.1 check_meminfo_real

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c $ARGV[1]`;
$dataIn =~ s/: /:/;
$dataIn =~ s/\|//;
print "$dataIn";

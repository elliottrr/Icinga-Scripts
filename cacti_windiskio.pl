#!/usr/bin/perl

use strict;

# Check Disk IO on Windows
#
# Example cacti_windiskio.pl <ipaddr> <diskID>

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $reads;
my $writes;

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_pdh -a "counter=\\PhysicalDisk($ARGV[1])\\Disk Write Bytes/sec"`;
@values = split(" = ", $dataIn);
$writes = $values[1];

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_pdh -a "counter=\\PhysicalDisk($ARGV[1])\\Disk Read Bytes/sec"`;
@values = split(" = ", $dataIn);
$reads = $values[1];

printf "Disk:%s Read:%d Write:%d\n",$ARGV[1],$reads,$writes;

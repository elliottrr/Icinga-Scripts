#!/usr/bin/perl

use strict;

# Check MemInfo on Windows
# This script translates the output format from check_meminfo_[total|swap|active]
# into a format that Cacti can understand
# Usage: cacto_meminfo.pl <ipaddr> <call_name>
#
# Example cacti_meminfo.pl 127.0.0.1 check_meminfo_real

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $thrtys;
my $onemin;
my $fivemin;


$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c $ARGV[1]`;
$dataIn =~ s/\|/=/g;
$dataIn =~ s/%//g;
@values = split("=", $dataIn);

#foreach (@values)
#{
#	print "$_\n";
#}


@tmpy = split(";", $values[2]);
$fivemin = $tmpy[0];
@tmpy = split(";", $values[3]);
$onemin = $tmpy[0];
@tmpy = split(";", $values[4]);
$thrtys = $tmpy[0];

printf "FiveMin:%d OneMin:%d ThirtySec:%d\n",$fivemin,$onemin,$thrtys;

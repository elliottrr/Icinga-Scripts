#!/usr/bin/perl

use strict;

# Check Network IO on Windows
#
# Example cacti_winnetio.pl <ipaddr> <NICID>

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $TX;
my $RX;

if ($ARGV[1] == "") { $ARGV[1] = "*"; }
if ($ARGV[1] == "all") { $ARGV[1] = "*"; }

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_pdh -a "counter=\\Network Interface(*)\\Bytes Received/sec"`;
@values = split(/[=|]/, $dataIn);
print "$dataIn\n";
#foreach(@values) {
#    print "$_\n";
#}
$RX = $values[1];
$RX =~ s/ //g;

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_pdh -a "counter=\\Network Interface(*)\\Bytes Sent/sec"`;
@values = split(/[=|]/, $dataIn);
print "$dataIn\n";
#foreach(@values) {
#    print "$_\n";
#}
$TX = $values[1];
$TX =~ s/ //g;

#print "RX:$RX TX:$TX";
printf "RX:%d TX:%d\n",$RX,$TX;

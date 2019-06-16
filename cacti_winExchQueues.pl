#!/usr/bin/perl

use strict;

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;


$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c check_queue`;
$dataIn =~ s/ //g;
$dataIn =~ s/\|//g;
$dataIn =~ s/outboundto//g;
$dataIn =~ s/,/;/g;
@tmpy = split(";", $dataIn);

printf "var0:%d ",$tmpy[1];
printf "var1:%d ",$tmpy[3];
printf "var2:%d ",$tmpy[5];
printf "label0:%s ",$tmpy[0];
printf "label1:%s ",$tmpy[2];
printf "label2:%s ",$tmpy[4];
print "\n";

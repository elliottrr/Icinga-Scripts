#!/usr/bin/perl

use strict;

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $conn;


$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 30 -H $ARGV[0] -c check_D2L_IIS_numcon -a oud2l 2000 3000`;
@values = split("=", $dataIn);
@tmpy = split(";", $values[1]);


$conn = $tmpy[0];

printf "Connections:%d\n",$conn;

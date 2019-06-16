#!/usr/bin/perl

use strict;

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $conn;


$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c check_wintcpconn -a 1000 2000`;
@values = split("=", $dataIn);
@tmpy = split(";", $values[1]);


$conn = $tmpy[0];

printf "Connections:%d\n",$conn;

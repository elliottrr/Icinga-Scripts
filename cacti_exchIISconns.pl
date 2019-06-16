#!/usr/bin/perl

use strict;

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $conn;
my $owa;
my $rpc;


$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c check_exchconn -a 2000 3000`;
@values = split("=", $dataIn);
@tmpy = split(";", $values[1]);
$conn = $tmpy[0];

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c check_exchconn -a 2000 3000 OWA`;
@values = split("=", $dataIn);
@tmpy = split(";", $values[1]);
$owa = $tmpy[0];

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $ARGV[0] -c check_exchconn -a 2000 3000 RPC`;
@values = split("=", $dataIn);
@tmpy = split(";", $values[1]);
$rpc = $tmpy[0];

printf "TOT:%d OWA:%d RPC:%d\n",$conn,$owa,$rpc;

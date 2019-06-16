#!/usr/bin/perl

use strict;

my $dataIn0 = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_conns_node0`;
my $dataIn1 = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c check_conns_node1`;
$dataIn0 =~ s/\n//g;
$dataIn1 =~ s/\n//g;
my @values0 = split("=", $dataIn0);
my @values1 = split("=", $dataIn1);
if ($values0[1] == "") { $values0[1] = -1; }
if ($values1[1] == "") { $values1[1] = -1; }

print "node0:$values0[1] node1:$values1[1]\n";

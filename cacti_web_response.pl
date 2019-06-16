#!/usr/bin/perl

use strict;

# Compare website response time between Norman and S2
my $chkhostNor	= "129.15.2.7";
my $chkhostS2	= "156.110.246.60";
my $site	= $ARGV[0];
my $checkName	= "check_web_$site";
my @tmp;
my $respNor;
my $respS2;

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $chkhostNor -c $checkName`;
#my $dataIn = "HTTP OK:HTTP/1.1 200 OK - 204478 bytes in 8.759 second response time time=8.758649s;;;0.000000 size=204478B;;;0";
$dataIn =~ s/: /:/;
$dataIn =~ s/\|//;
@tmp = split('=',$dataIn);
@tmp = split(';',$tmp[1]);
$respNor = $tmp[0];
$respNor =~s/s//;
if ($dataIn =~ "socket timeout") { $respNor = "-1"; }
#print "$dataIn";

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $chkhostS2 -c $checkName`;
$dataIn =~ s/: /:/;
$dataIn =~ s/\|//;
@tmp = split('=',$dataIn);
@tmp = split(';',$tmp[1]);
$respS2 = $tmp[0];
$respS2 =~s/s//;
if ($dataIn =~ "socket timeout") { $respS2 = "-1"; }
#print "$dataIn";

print "NOR:$respNor S2:$respS2 SITE:$site";

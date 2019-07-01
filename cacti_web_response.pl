#!/usr/bin/perl

use strict;

# Compare website response time between CorpNet and DCNet
my $chkhostCorpNet	= "<corporate-check-host>";
my $chkhostDCNet	= "<datacenter-check-host>";
my $site	= $ARGV[0];
my $checkName	= "check_web_$site";
my @tmp;
my $respCorpNet;
my $respDCNet;

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $chkhostCorpNet -c $checkName`;
#my $dataIn = "HTTP OK:HTTP/1.1 200 OK - 204478 bytes in 8.759 second response time time=8.758649s;;;0.000000 size=204478B;;;0";
$dataIn =~ s/: /:/;
$dataIn =~ s/\|//;
@tmp = split('=',$dataIn);
@tmp = split(';',$tmp[1]);
$respCorpNet = $tmp[0];
$respCorpNet =~s/s//;
if ($dataIn =~ "socket timeout") { $respCorpNet = "-1"; }
#print "$dataIn";

my $dataIn = `/usr/lib64/nagios/plugins/check_nrpe -t 60 -H $chkhostDCNet -c $checkName`;
$dataIn =~ s/: /:/;
$dataIn =~ s/\|//;
@tmp = split('=',$dataIn);
@tmp = split(';',$tmp[1]);
$respDCNet = $tmp[0];
$respDCNet =~s/s//;
if ($dataIn =~ "socket timeout") { $respDCNet = "-1"; }
#print "$dataIn";

print "NOR:$respCorpNet DCNet:$respDCNet SITE:$site";

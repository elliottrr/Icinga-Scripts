#!/usr/bin/perl
use strict;
use Scalar::Util qw(looks_like_number);


# Report Dell open manage temperature in Cacti format

my $cmdString = "/opt/dell/srvadmin/bin/omreport chassis temps index=1|/bin/grep Reading";
my $rawData = `$cmdString`;
$rawData =~ s/Reading//g;
$rawData =~ s/://g;
$rawData =~ s/C//g;
$rawData =~ s/ //g;
$rawData =~ s/\n//g;

if(looks_like_number($rawData)) {
	$rawData = (($rawData * 9) / 5) + 32;
	print "temp:$rawData\n";
} else {
	print "temp:ERR";
}

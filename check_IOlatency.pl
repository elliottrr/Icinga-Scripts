#!/usr/bin/perl
use strict;

my $iostatcmd	= "/usr/bin/iostat -yxk -j ID 10 1|grep scsi";
my $iostats	= `$iostatcmd`;
$iostats =~ s/   / /g;
$iostats =~ s/  / /g;
$iostats =~ s/  / /g;
my @devices	= split('\n', $iostats);
my $device;
my @stats;
my $idx		= 0;
my $awaitSum	= 0;
my $await	= 0;	# Average Wait, Stat 9
my $rwaitSum	= 0;
my $rwait	= 0;	# Read Wait, Stat 10
my $wwaitSum	= 0;
my $wwait	= 0;	# Write Wait, Stat 11
my $utilSum	= 0;
my $util	= 0;	# Utilization %, Stat 13

#print "ID\taWait\trWait\twWait\tUtil%\n";
foreach $device (@devices) 
{
#	print "$device\n";
	@stats = split(' ', $device);
	$awaitSum = $awaitSum + $stats[9];
	$rwaitSum = $rwaitSum + $stats[10];
	$wwaitSum = $wwaitSum + $stats[11];
	$utilSum = $utilSum + $stats[13];
	$idx++;
#	print "$idx\t$stats[9]\t$stats[10]\t$stats[11]\t$stats[13]\n";
}

$await = $awaitSum / $idx;
$rwait = $rwaitSum / $idx;
$wwait = $wwaitSum / $idx;
$util = $utilSum / $idx;

print "AWait:$await  RWait:$rwait  WWait:$wwait  Util:$util\n";
#print "\n";
#print "Total Devices: $idx\n";
#print "Average Wait: $await ms\n";
#print "Avg Read Wait: $rwait ms\n";
#print "Avg Write Wait: $wwait ms\n";
#print "Avg Utilization: $util %\n";

#!/usr/bin/perl

use strict;

my $numArgs = $#ARGV;
my $exit = 3; 	# 3=Unknown
my $exitCode = "UNKNOWN";
my $numProcs = `/bin/cat /proc/cpuinfo | /bin/grep processor | /usr/bin/wc -l`;
if ($numArgs != 1)
{
	print "check_uptime\n";
	print "6/23/2014 by Elliott\n";
	print "\n";
	print "Check the uptime of a host. Reports OK, Warning, or Critical\n";
	print "based on comparison with supplied 'warn' and 'crit' values in seconds \n";
	print "\n";
	print "Usage:\t\t./check_uptime warn crit\n";
	print "Example:\t./check_uptime 1200 600\n";
	print "\n";
} else {
	my $upfile = "/proc/uptime";
	open FILE, "<", $upfile or die $!;
	my $data = <FILE>;
	close FILE;

	$data =~ s/\n//;
	$numProcs =~ s/\n//;
	my @time = split(' ',$data);
	my $uptime = $time[0];
	my $idle = $time[1];
	$idle = $idle / $numProcs;
	my $idleTime = ($idle / $uptime) * 100;
	$idleTime = sprintf("%.1f",$idleTime);
	$idle = sprintf("%.1f",$idle);
	$exit = 0;
	$exitCode = "OK";
	if ($uptime < $ARGV[0]) { $exit = 1; $exitCode = "WARNING"; }
	if ($uptime < $ARGV[1]) { $exit = 2; $exitCode = "CRITICAL"; }

	print "UPTIME $exitCode: Up $uptime Seconds; Idle $idle Seconds; $idleTime% Idle; $numProcs Processors";
}
exit ($exit);

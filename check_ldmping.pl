#!/usr/bin/perl

use strict;

my $ipaddr = $ARGV[0];
#my $pingcmd = "/usr/bin/sudo /opt/ldm/bin/ldmping -v -l - -t 8 -i 0 -h $ipaddr 2>&1;echo \$?";
my $pingcmd = "/opt/ldm/bin/ldmping -v -l - -t 8 -i 0 -h $ipaddr 2>&1;echo \$?";
my $exit = 0;
my $exittext;
my $pingout = `$pingcmd`;
my @output = split(/\n/,$pingout);
my $pingexit = $output[-1];

if ($pingexit == 0)
{
	$exittext = "LDMPING OK: $output[-2]";
	$exit = 0;
} else {
	$exittext = "LDMPING CRITICAL: No response from $ipaddr";
	$exit = 2;
}

print "$exittext\n";
exit($exit);

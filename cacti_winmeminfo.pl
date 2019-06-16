#!/usr/bin/perl

use strict;

# Check MemInfo on Windows
# This script translates the output format from check_meminfo_[total|swap|active]
# into a format that Cacti can understand
# Usage: cacto_meminfo.pl <ipaddr> <call_name>
#
# Example cacti_meminfo.pl 127.0.0.1 check_meminfo_real

my $dataIn;
my @values;
my $idx = 0;
my $tmp;
my @tmpy;
my $phtotl;
my $phused;
my $pgtotl;
my $pgused;

sub toBytes
{
	my $in = $_[0];
	my $sfx = substr($in,-2);
	$sfx =~ s/[0-9]//g;
	$in = substr($in,0,-1);
	if ($sfx eq 'K') { $in = $in * 1024; } 
	if ($sfx eq 'KB') { $in = $in * 1024; } 
	if ($sfx eq 'M') { $in = $in * 1048576; } 
	if ($sfx eq 'MB') { $in = $in * 1048576; } 
	if ($sfx eq 'G') { $in = $in * 1073741824; } 
	if ($sfx eq 'GB') { $in = $in * 1073741824; } 
	return $in;
}

$dataIn = `/usr/lib64/nagios/plugins/check_nrpe -H $ARGV[0] -c $ARGV[1]`;
$dataIn =~ s/\|/-/g;
$dataIn =~ s/- //g;
@values = split(": ", $dataIn);

@tmpy = split(" ", $values[3]);
$phtotl = $tmpy[0];
$phtotl = toBytes($phtotl);
@tmpy = split(" ", $values[4]);
$phused = $tmpy[0];
$phused = toBytes($phused);
@tmpy = split(" ", $values[15]);
$pgtotl = $tmpy[0];
$pgtotl = toBytes($pgtotl);
@tmpy = split(" ", $values[16]);
$pgused = $tmpy[0];
$pgused = toBytes($pgused);

printf "PhyTotal:%d PhyUsed:%d PageTotal:%d PageUsed:%d\n",$phtotl,$phused,$pgtotl,$pgused;

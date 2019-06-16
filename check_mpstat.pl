#!/usr/bin/perl
use strict;

my $mpsOut = `/usr/bin/mpstat 1 5`;
my @output = split('\n',$mpsOut);

@output = split(' ',$output[8]);

print "User:$output[2] ";
print "Nice:$output[3] ";
print "Sys:$output[4] ";
print "IOwait:$output[5] ";
print "IRQ:$output[6] ";
print "Soft:$output[7] ";
print "Steal:$output[8] ";
print "Guest:$output[9] ";
#print "Idle:$output[10]\n";
print "Idle:0.00\n";


exit(0);

#!/usr/bin/perl
use strict;
use DBI;

my $db = "LDMstatistics";
my $dbuser = "ldm";
my $dbpass = "LDMpasswd";
my $dbhost = "localhost";
my $ldmhost = "Thanatos";
my $doscr = "^M";
my $feed = $ARGV[0];
my $site = $ARGV[1];

my $query = "SELECT MAX(latency) FROM feedstats WHERE insertTime=(SELECT MAX(insertTime) FROM feedstats WHERE site='$site' and feed='$feed' ORDER BY insertTime);";

my $dbh = DBI->connect("DBI:mysql:$db:$dbhost", $dbuser, $dbpass);
my $sqlQuery  = $dbh->prepare($query)
or die "Can't prepare $query: $dbh->errstr\n";
 
my $rv = $sqlQuery->execute
or die "can't execute the query: $sqlQuery->errstr";

while ( my @row = $sqlQuery->fetchrow_array( ) )  {
         print "$row[0]|0|00:00:00|$site $feed Latency\n";
}


my $rc = $sqlQuery->finish;
exit(0);

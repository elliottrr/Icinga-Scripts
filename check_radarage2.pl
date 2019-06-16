#!/usr/bin/perl
use strict;
use DBI;

my $db = "LDMstatistics";
my $dbuser = "ldm";
my $dbpass = "LDMpasswd";
my $dbhost = "localhost";
#my $ldmhost = "Thanatos";
my $state = "OK";
my $exit = 0;
my $age;
my $doscr = "^M";
my $lvl = $ARGV[0];
my $host = $ARGV[1];
my $warn = $ARGV[2];
my $crit = $ARGV[3];
my $table = "feedstats";

$lvl = substr($lvl,0,4);

#if (($host eq "Ingest0") || ($host eq "Ingest1")) { $table = $lvl . $host; }
if (($host eq "Ingest0") || ($host eq "Ingest1") || ($host eq "Ingest2")) { $table = $lvl . $host; }
if (($host eq "Node0") || ($host eq "Node1")) { $table = $lvl . $host; }

my $query = "SELECT (UNIX_TIMESTAMP(NOW()) - (SELECT UNIX_TIMESTAMP(insertTime) FROM $table WHERE UNIX_TIMESTAMP(insertTime) > (UNIX_TIMESTAMP(NOW()) - 1200) ORDER BY insertTime DESC LIMIT 0,1)) AS Delay;";

if ($lvl eq "CD") { $query = "SELECT (UNIX_TIMESTAMP(NOW()) - (SELECT UNIX_TIMESTAMP(insertTime) FROM feedstats WHERE UNIX_TIMESTAMP(insertTime) > (UNIX_TIMESTAMP(NOW()) - 14400) AND feed = 'CONDUIT' AND host = '$host' ORDER BY insertTime DESC LIMIT 0,1)) AS Delay;;"; }

if ($lvl eq "NDFD") { $query = "SELECT (UNIX_TIMESTAMP(NOW()) - (SELECT UNIX_TIMESTAMP(insertTime) FROM feedstats WHERE UNIX_TIMESTAMP(insertTime) > (UNIX_TIMESTAMP(NOW()) - 21600) AND feed = 'CONDUIT' AND site = 'NDFD' AND host = '$host' ORDER BY insertTime DESC LIMIT 0,1)) AS Delay;;"; }

my $dbh = DBI->connect("DBI:mysql:$db:$dbhost", $dbuser, $dbpass);
my $sqlQuery  = $dbh->prepare($query)
or die "Can't prepare $query: $dbh->errstr\n";
 
my $rv = $sqlQuery->execute
or die "can't execute the query: $sqlQuery->errstr";

#while ( my @row = $sqlQuery->fetchrow_array( ) )  {
#	if ($row[0] eq "") { $row[0] = 0; }
#	print "$row[0]|$row[1]|00:00:00|$host $lvl Latency\n";
#}

while ( my @row = $sqlQuery->fetchrow_array( ) )  {
        $age = $row[0];
        if ($age >= $warn) { $exit = 1; $state = "WARNING"; }
        if ($age >= $crit) { $exit = 2; $state = "CRITICAL"; }
        if ($age == "") { $exit = 2; $state = "CRITICAL"; $age = "UNKNOWN"; }
        print "$state - $age seconds since $lvl data was received by $host\n";
}

my $rc = $sqlQuery->finish;
exit($exit);

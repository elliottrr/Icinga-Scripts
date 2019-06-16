#!/usr/bin/perl
use strict;
use DBI;

my $db = "LDMstatistics";
my $dbuser = "ldm";
my $dbpass = "LDMpasswd";
my $dbhost = "localhost";
#my $ldmhost = "Thanatos";
my $doscr = "^M";
my $lvl = $ARGV[0];
my $host = $ARGV[1];
my $site = $ARGV[2];
my $siteq = "";
my $table = "feedstats";

$lvl = substr($lvl,0,2);

$site = substr($site,0,4);
if ($site ne "") { $siteq = "AND site = '$site'"; }

if (($host eq "Ingest0") || ($host eq "Ingest1") || ($host eq "Ingest2")) { $table = $lvl . $host; }
if (($host eq "Node0") || ($host eq "Node1")) { $table = $lvl . $host; }
if (($host eq "Charlie") || ($host eq "Delta")) { $table = $lvl . $host; }
#if ($lvl eq "L2") { $lvl = "NEXRAD2"; }
#if ($lvl eq "L3") { $lvl = "NEXRAD3"; }
#if ($lvl eq "CN") { $lvl = "CANRAD"; }
#if ($lvl eq "CD") { $lvl = "CONDUIT"; }

my $query = "SELECT AVG(latency),COUNT(*) FROM $table WHERE UNIX_TIMESTAMP(insertTime) > (UNIX_TIMESTAMP(NOW()) - 300)$siteq;";
#my $query = "SELECT AVG(latency),COUNT(*) FROM statusData WHERE UNIX_TIMESTAMP(lastInsert) > (UNIX_TIMESTAMP(NOW()) - 300) AND host = '$host' AND feed = '$lvl' $siteq;";

if ($lvl eq "CD") { $query = "SELECT AVG(latency),COUNT(*) FROM feedstats WHERE UNIX_TIMESTAMP(insertTime) > (UNIX_TIMESTAMP(NOW()) - 300) AND feed = 'CONDUIT' AND host = '$host'$siteq;"; }

my $dbh = DBI->connect("DBI:mysql:$db:$dbhost", $dbuser, $dbpass);
my $sqlQuery  = $dbh->prepare($query)
or die "Can't prepare $query: $dbh->errstr\n";
 
my $rv = $sqlQuery->execute
or die "can't execute the query: $sqlQuery->errstr";

while ( my @row = $sqlQuery->fetchrow_array( ) )  {
	if ($row[0] eq "") { $row[0] = 0; }
	if ($row[0] == 0) { $row[0] = -1; }
	print "$row[0]|$row[1]|00:00:00|$host $lvl $site Latency\n";
}

my $rc = $sqlQuery->finish;
#print "$query\n";
exit(0);

#!/usr/bin/perl
use strict;
use DBI;

my $db = "LDMstatistics";
my $dbuser = "ldm";
my $dbpass = "LDMpasswd";
my $dbhost = "localhost";
my $ldmhost = "Thanatos";
my $doscr = "^M";
my $avg10;
my $avg30;
my $avg60;
my $sitetxt = "";
my $site = $ARGV[0];
$site = substr($site,0,4);

if ($site ne "") { $sitetxt = " AND site = '$site'"; }

my $query1 = "SELECT AVG(cutRatio) FROM L2statistics WHERE host='$ldmhost' AND createTime > FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - 900)$sitetxt;";
my $query2 = "SELECT AVG(cutRatio) FROM L2statistics WHERE host='$ldmhost' AND createTime > FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - 1800)$sitetxt;";
my $query3 = "SELECT AVG(cutRatio) FROM L2statistics WHERE host='$ldmhost' AND createTime > FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - 3600)$sitetxt;";

#print "$query1\n";

my $dbh = DBI->connect("DBI:mysql:$db:$dbhost", $dbuser, $dbpass);

my $sqlQuery  = $dbh->prepare($query1) or die "Can't prepare $query1: $dbh->errstr\n";
my $rv = $sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";
while ( my @row = $sqlQuery->fetchrow_array( ) )  {
        $avg10 = $row[0];
}
my $sqlQuery  = $dbh->prepare($query2) or die "Can't prepare $query2: $dbh->errstr\n";
my $rv = $sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";
while ( my @row = $sqlQuery->fetchrow_array( ) )  {
        $avg30 = $row[0];
}
my $sqlQuery  = $dbh->prepare($query3) or die "Can't prepare $query3: $dbh->errstr\n";
my $rv = $sqlQuery->execute or die "can't execute the query: $sqlQuery->errstr";
while ( my @row = $sqlQuery->fetchrow_array( ) )  {
        $avg60 = $row[0];
}

printf "val1:%.2f val2:%.2f val3:%.2f\n",$avg10,$avg30,$avg60;

my $rc = $sqlQuery->finish;
exit(0);

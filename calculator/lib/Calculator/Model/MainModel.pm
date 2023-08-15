package Calculator::Model::MainModel;
use DBI;
use strict;
use warnings;

my $dbh = DBI->connect("dbi:mysql:mysql_read_default_file=".($ENV{HOME}||"/home/www")."/.database.cnf".";mysql_read_default_group=test", undef, undef, {}) or die "Could not connect to the database";

sub get_history {
  return $dbh ->selectall_arrayref("SELECT * FROM CalculatorHistory;", { Slice => {} });
}

sub post_history {
  my ($num1, $num2, $operator, $result) = @_;
  my $sth = $dbh->prepare("INSERT INTO CalculatorHistory VALUES(?, ?, ?, ?)");
  $sth->execute( $num1, $num2, $operator, $result );
  $dbh->commit;
}

1;

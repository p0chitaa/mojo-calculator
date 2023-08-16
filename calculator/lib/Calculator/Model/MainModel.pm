package Calculator::Model::MainModel;
use DBI;
use strict;
use warnings;

my $dbh = DBI->connect("dbi:mysql:mysql_read_default_file=".($ENV{HOME}||"/home/www")."/.database.cnf".";mysql_read_default_group=test", undef, undef, {}) or die "Could not connect to the database";

sub check_for_user {
  my ($username, $password) = @_;
  my $sql = "SELECT 1 FROM CalculatorUsers WHERE id = ? AND password = ?;";
  my $sth = $dbh->prepare($sql);
  $sth->execute($username, $password);
  my $value = $sth->fetchrow_arrayref;
  if ($value) {
    return 1;
  } else {
    return 0;
  }
}

sub get_history {
  my $username = $_[0];

  my $sql = "SELECT * FROM CalculatorHistory WHERE id = ?;";

  return $dbh->selectall_arrayref($sql, { Slice => {} }, $username);
}

sub post_history {
  my ($num1, $num2, $operator, $result, $username) = @_;
  my $sth = $dbh->prepare("INSERT INTO CalculatorHistory VALUES(?, ?, ?, ?, ?);");
  $sth->execute( $num1, $num2, $operator, $result, $username );
  # $dbh->commit;
}

1;

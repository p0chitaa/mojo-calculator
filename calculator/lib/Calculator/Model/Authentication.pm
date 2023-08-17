package Calculator::Model::Authentication;
use Expect;
use DBI;
use Data::Dumper;

my $dbh = DBI->connect("dbi:mysql:mysql_read_default_file=".($ENV{HOME}||"/home/www")."/.database.cnf".";mysql_read_default_group=test", undef, undef, {}) or die "Could not connect to the database";


# in a nutshell, this hashes the attempted password and checks to see if it matches a passed hash
sub validate_password {
  # ok, params, yeah
  my ($attempt,$hash) = @_;
  $attempt .= "\n"; 

  # regex, but what do??
  # plug into GPT
  $hash =~ m/\$apr1\$(.+)\$/;

  # is this just basically "true" for the line below?
  my $salt = $1;


  # what does the salt string look like??
  # which hashing method is being used? is there a default? (looking it up it should be SHA-256) - apr1
  # does this just spawn this openssl process??
  my $session = Expect->spawn("openssl passwd -apr1 -salt $salt") or die "Error calling external program: $!";
  
  # logs 0?
  $session->log_stdout(0);

  # ask GPT, docs
  $session->expect(5, [ qr{Password}, sub { 
        # file handler?
        my $fh = shift;

        # sends unhashed attempt to file?
        $fh->send($attempt); 

        # ??
        exp_continue;
  }]); # no clue what this thing does


  # ->before()? what is this
  my $attempt_hash = $session->before();

  $attempt_hash =~ m/\$apr1(.+)/;

  # ??
  $attempt_hash = "\$apr1$1";

  # ??
  $session->soft_close();

  # removes newline?
  chop $attempt_hash;

  # checks if passed hash matches hashed passed password
  if ($hash eq $attempt_hash) {
    return 1;
  } else {
    return 0;
  }
}


sub validate_credentials {
  # ok yeah more params
  my ($id,$attempted_password) = @_;

  # creates hash scalar equal to an existing hashed password in the database given a matching id
  my $hash = $dbh->selectrow_hashref('SELECT pass_hash FROM CalculatorUsers WHERE id=?', { Slice => {} }, $id);

  # user doesn't exist
  return 0 if !defined $hash;

  # calls above function with attempted password and existing hash in database if exists
  return (validate_password($attempted_password,$hash->{pass_hash}) == 1) ? 1 : 0;
}


# store hashes in database? hash through external source?

# print validate_credentials("drew", "test");

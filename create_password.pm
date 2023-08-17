use Expect;

sub create_password {
  my $password = shift;
  $password .= "\n";
  my $session = Expect->spawn('openssl passwd -noverify -apr1') or die "Error calling external program: $!";
  $session->log_stdout(0);
  $session->expect(5, [ qr{Password}, sub { 
        my $fh = shift;
        $fh->send($password);
        exp_continue;
  }]);
  my $hash = $session->before();
  $hash =~ m/\$apr1(.+)/;
  $hash = "\$apr1$1";
  chop $hash;
  $session->soft_close();
  return ($hash =~ m/\$apr1\$/) ? $hash : undef;
}

my $hash = create_password("return");
print $hash;


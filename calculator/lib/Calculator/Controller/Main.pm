package Calculator::Controller::Main;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Calculator::Model::MainModel;
use Data::Dumper;

sub calculator {
  my $self = shift;
  $self->render('calculator');
}

sub calculate {
    my $self = shift;

    my $username = $self->session("username");

    my $data = $self->req->json;
    my $num1 = $data->{num1};
    my $num2 = $data->{num2};
    my $operator = $data->{operator};
    my $result = 0;

    if($operator eq "+") {
        $result = $num1 + $num2;
    } elsif($operator eq "-") {
        $result = $num1 - $num2;
    } elsif($operator eq "*") {
        $result = $num1 * $num2;
    } elsif($operator eq "//") {
        my $pre_rounded = $num1 / $num2;
        if($num1 % $num2 == 0) {
          $result = $pre_rounded
        } else {
          $result = sprintf "%.6f", $pre_rounded;
        }    
    
        #my $places = 6;
        #my $factor = 10**$places;
        #my $pre_rounded = $num1 / $num2;
        #$result = int($pre_rounded * $factor) / $factor;
    } elsif($operator eq "%") {
        $result = $num1 % $num2;
    }

    Calculator::Model::MainModel::post_history($num1, $num2, $operator, $result, $username);

    $self->render(json => { num1 => $num1, num2 => $num2, operator => $operator, result => $result });
}

sub get_history {
    my $self = shift;
    my $username = $self->session("username");
    print "\n\nPassed username: $username\n\n";

    print "\n\n".Dumper(Calculator::Model::MainModel::get_history($username))."\n\n";

    $self->render(json => Calculator::Model::MainModel::get_history($username));
}

1;

package Calculator::Controller::Main;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub calculator {
  my $self = shift;
  $self->render('calculator');
}

sub calculate {
    my $self = shift;

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
        $result = $num1 / $num2;
    } elsif($operator eq "%") {
        $result = $num1 % $num2;
    }

    $self->render(json => { num1 => $num1, num2 => $num2, operator => $operator, result => $result });
}

1;

#!/usr/bin/env perl
use Mojolicious::Lite -signatures;

any '/' => sub ($c) {
    my $result = 0;
    $c->render(template => 'calc', result => $result);
};

any '/calculate' => sub {
    my $c = shift;

    my $data = $c->req->json;
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

    $c->render(json => { num1 => $num1, num2 => $num2, operator => $operator, result => $result });
};

app->start;
#!/usr/bin/env perl
use Mojolicious::Lite -signatures;
use Mojo::DOM;

any '/' => sub ($c) {
    my $result = 0;
    my $num1 = "";
    $c->render(template => 'newcalc', num1 => $num1, result => $result);
};

post '/calculate' => sub ($c) {
    my $result = 0;
    my $num1 = $c->param('num1');
    my $num2 = $c->param('num2');
    my $operation = $c->param('operation');

    if($operation eq "add") {
        $result = $num1 + $num2;
    } elsif($operation eq "subtract") {
        $result = $num1 - $num2;
    } elsif($operation eq "multiply") {
        $result = $num1 * $num2;
    } elsif($operation eq "divide") {
        $result = $num1 / $num2;
    } elsif($operation eq "modulo") {
        $result = $num1 % $num2;
    }

    $c->render(template => 'newcalc', num1 => $result, result => $result);#, text => "Num 1: $num1\nNum 2: $num2\nOperator: $operation");
};

app->start;
__DATA__

@@ newcalc.html.ep

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Calculator!</title>
</head>
<body>
<div class="calculator">
    <form id="calcForm" action="/calculate" method="post">
        <input type="number" name="num1" placeholder="Enter first number" value=<%= $num1 %>>
        <select name="operation">
            <option value="add">+</option>
            <option value="subtract">-</option>
            <option value="multiply">*</option>
            <option value="divide">/</option>
            <option value="modulo">%</option>
        </select>
        <input type="number" name="num2" placeholder="Enter second number">
        <input type="submit" value="Calculate">
    </form>
    <p>Result: <span id="result"><%= $result %></span></p>
</div>
</body>
</html>

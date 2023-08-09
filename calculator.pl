#!/usr/bin/env perl
use Mojolicious::Lite -signatures;
use Mojo::DOM;

any '/' => sub ($c) {
    my $result = 0;
    $c->render(template => 'newcalc', result => $result);
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
    }

    $c->render(template => 'newcalc', result => $result);#, text => "Num 1: $num1\nNum 2: $num2\nOperator: $operation");
};

app->start;
__DATA__

@@ newcalc.html.ep

<!DOCTYPE html>
<html lang="en">
<body>
<div class="calculator">
    <form id="calcForm" action="/calculate" method="post">
        <input type="number" name="num1" placeholder="Enter first number">
        <select name="operation">
            <option value="add">+</option>
            <option value="subtract">-</option>
            <option value="multiply">*</option>
            <option value="divide">/</option>
        </select>
        <input type="number" name="num2" placeholder="Enter second number">
        <input type="submit" value="Calculate">
    </form>
    <p>Result: <span id="result"><%= $result %></span></p>
</div>
</body>
</html>

@@ calc.html.ep

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculator!</title>
</head>
<style>
    body {
        background-color: rgba(20, 20, 20);
    }
    #calculator {
        margin: auto;
        width: 80%;
        height: 20%;
        padding: 10px;
    }

    #results-box {
        margin: auto;
        padding: 20px;
        width: 90%;
        background-color: rgba(50, 50, 50, 0.8);
        height: 10%;
        border-radius: 200px;
    }

    #results {
        margin: auto;
        margin-right: 20px;
        color: white;
        display: flex;
        justify-content: flex-end;
        font-size: 3.5rem;
        font-family: 'Inter', sans-serif;
    }

    #number-grid {
        margin: auto;
        margin-top: 10px;
        display: grid;
        grid-gap: 15px;
        grid-template-columns: auto auto auto;
        width: 93.9%;
    }
    
    .calc-button {
        border: 2px solid rgba(230, 230, 230, 0);
        padding-top: 20%;
        padding-bottom: 20%;
        text-align: center;
        background-color: rgba(70, 70, 70, 0.8);
        font-family: 'Inter', sans-serif;
        font-size: 3rem;
        border-radius: 200px;
        color: rgba(230, 230, 230)
    }

    .calc-button:hover {
        background-color: rgba(120, 120, 120, 0.8);
        transition: 0.05s;
    }
    
    .calc-button:active {
        background-color: rgba(200, 200, 200, 0.8);
    }

    #zero-button {
        grid-area: 5 / 1 / span 1 / span 2;
        border: 2px solid rgba(230, 230, 230, 0);
        padding: 10%;
        font-family: 'Inter', sans-serif;
        font-size: 3rem;
        text-align: center;
        background-color: rgba(70, 70, 70, 0.8);
        border-radius: 200px;
        color: rgba(230, 230, 230)
    }

    #zero-button:hover {
        background-color: rgba(120, 120, 120, 0.8);
        transition: 0.05s;
    }
    
    #zero-button:active {
        background-color: rgba(200, 200, 200, 0.8);
    }

    #dot {
        grid-area: 5 / 3;
        border: 2px solid rgba(230, 230, 230, 0);
        padding: 20%;
        font-family: 'Inter', sans-serif;
        font-size: 3rem;
        font-weight: 600;
        text-align: center;
        background-color: rgba(70, 70, 70, 0.8);
        border-radius: 200px;
        color: rgba(230, 230, 230)
    }

    #dot:hover {
        background-color: rgba(120, 120, 120, 0.8);
        transition: 0.05s;
    }
    
    #dot:active {
        background-color: rgba(200, 200, 200, 0.8);
    }

    #operator {
        background-color: rgba(255, 165, 0);
    }

    #operator:hover {
        background-color: rgba(255, 200, 0, 0.95);
        transition: 0.05s;
    }
    
    #operator:active {
        background-color: rgba(255, 230, 0);
    }
</style>
<body>
    <div id="calculator">
        <div id="results-box">
            <p id="results"><%= $result %></p>
        </div>
        <div id="number-grid">
            <button type="submit" class="calc-button" value="/" id="operator"
                style="grid-area: 1 / 4;">÷</button>
            <button type="submit" class="calc-button" value="*" id="operator"
                style="grid-area: 2 / 4;">x</button>
            <button type="submit" class="calc-button" value="-" id="operator"
                style="grid-area: 3 / 4;">-</button>
            <button type="submit" class="calc-button" value="+" id="operator"
                style="grid-area: 4 / 4;">+</button>
            <button type="submit" class="calc-button" value="=" id="operator"
                style="grid-area: 5 / 4;">=</button>
            <button type="submit" class="calc-button" value="C">C</button>
            <button type="submit" class="calc-button" value="negate" style="font-size:1.75rem;">+/-</button>
            <button type="submit" class="calc-button" value="%" style="font-size:2.2rem;">%</button>
            <button type="submit" class="calc-button" value="7">7</button>
            <button type="submit" class="calc-button" value="8">8</button>
            <button type="submit" class="calc-button" value="9">9</button>  
            <button type="submit" class="calc-button" value="4">4</button>
            <button type="submit" class="calc-button" value="5">5</button>
            <button type="submit" class="calc-button" value="6">6</button>  
            <button type="submit" class="calc-button" value="1">1</button>
            <button type="submit" class="calc-button" value="2">2</button>
            <button type="submit" class="calc-button" value="3">3</button>  
            <button type="submit" id="zero-button" value="0">0</button>
            <button type="submit" id="dot" value=".">.</button>
        </div>
    </div>
</body>
</html>
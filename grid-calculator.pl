#!/usr/bin/env perl
use Mojolicious::Lite -signatures;

any '/' => sub ($c) {
    my $result = 0;
    $c->render(template => 'calc', result => $result);
};

app->start;
__DATA__

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
        overflow: hidden;
        max-width: 460px;
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

    #first-results {
        margin: auto;
        margin-right: 20px;
        color: white;
        display: flex;
        justify-content: flex-end;
        font-size: 3.5rem;
        font-family: 'Inter', sans-serif;
    }

    #second-results {
        margin: auto;
        margin-right: 20px;
        color: white;
        display: flex;
        justify-content: flex-end;
        font-size: 3.5rem;
        font-family: 'Inter', sans-serif;
        display: none;
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
            <!--<p id="results"><%= $result %></p>-->

            <!-- rename to first-num and second-num!!! -->
            <p id="first-results">0</p>
            <p id="second-results">0</p>
        </div>
        <div id="number-grid">
            <button type="submit" class="calc-button" value="/" id="operator"
                style="grid-area: 1 / 4;font-size:2.5rem;">÷</button>
            <button type="submit" class="calc-button" value="*" id="operator"
                style="grid-area: 2 / 4;font-size:2.5rem;">x</button>
            <button type="submit" class="calc-button" value="-" id="operator"
                style="grid-area: 3 / 4;">-</button>
            <button type="submit" class="calc-button" value="+" id="operator"
                style="grid-area: 4 / 4;">+</button>
            <button type="submit" class="calc-button" value="=" id="operator"
                style="grid-area: 5 / 4;font-size:2.5rem;">=</button>
            <button type="submit" id="C" class="calc-button" value="C">C</button>
            <button type="submit" id="negate" class="calc-button" value="negate" style="font-size:1.75rem;">+/-</button>
            <button type="submit" id="mod" class="calc-button" value="%" style="font-size:2.2rem;">%</button>
            <button type="submit" id="7" class="calc-button" value="7">7</button>
            <button type="submit" id="8" class="calc-button" value="8">8</button>
            <button type="submit" id="9" class="calc-button" value="9">9</button>  
            <button type="submit" id="4" class="calc-button" value="4">4</button>
            <button type="submit" id="5" class="calc-button" value="5">5</button>
            <button type="submit" id="6" class="calc-button" value="6">6</button>  
            <button type="submit" id="1" class="calc-button" value="1">1</button>
            <button type="submit" id="2" class="calc-button" value="2">2</button>
            <button type="submit" id="3" class="calc-button" value="3">3</button>  
            <button type="submit" id="zero-button" value="0">0</button>
            <button type="submit" id="dot" value=".">.</button>
        </div>
    </div>
</body>
</html>
% All coefficients considered
function f = objfun(x)
f = 6.9523+0.2413*x(1)+1.2600*x(2)-0.2838*x(3);
f=-f;
end
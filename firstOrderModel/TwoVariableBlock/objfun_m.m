% Coefficients that failed the t-test are eliminated
function f = objfun_m(x)
f = 6.9523+1.2600*x(2);
f = -f;
end
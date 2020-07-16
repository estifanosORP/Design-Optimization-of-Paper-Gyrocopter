% Coefficients that failed the t-test are eliminated
function f = objfun_m(x)
f = 8.1900+1.2600*x(2)-1.0713*(x(1))^2;
f = -f;
end
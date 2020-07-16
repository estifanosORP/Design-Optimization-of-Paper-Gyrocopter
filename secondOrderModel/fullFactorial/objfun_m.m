% Coefficients that failed the t-test are eliminated
function f = objfun_m(x)
f = 7.5169+0.8858*x(2)-0.4661*x(3)-0.6519*(x(1))^2;
f = -f;
end
% Coeffcients that failed the t-test are elminated
function f = objfun_m(x)
f = 6.9040+0.8856*x(2)-0.4661*x(3);
f = -f;
end
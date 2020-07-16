% All Coeffcients considered
function f = objfun(x)
f = 6.9040+0.2556*x(1)+0.8856*x(2)-0.4661*x(3);
f=-f;
end
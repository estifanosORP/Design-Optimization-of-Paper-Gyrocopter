clear all; clc
% format long
x0 = [0,0,0];
lb = [-1,-1,-1];
ub = [1,1,1];
options = optimset('largescale', 'off');
[x, fval] = fmincon('objfun', x0,[],[],[],[],lb,ub,[],options)
[x_m, fval_m] = fmincon('objfun_m', x0,[],[],[],[],lb,ub,[],options)

d = [40*x(1)+140, 20*x(2) + 50, 10*x(3) + 30]          % optimized natural variables for objfun
d_m = [40*x_m(1)+140, 20*x_m(2) + 50, 10*x_m(3) + 30]  % optimized natural variables for objfun_m




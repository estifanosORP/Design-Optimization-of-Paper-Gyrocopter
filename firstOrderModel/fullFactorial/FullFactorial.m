clear all; clc

% Natural Variable
load d

% Response variable for three trials
load t

% Average value of response
t_ave = mean(t,2);
y = t_ave;

% Coded Variable
d1 = d(:,1); d2 = d(:,2); d3 = d(:,3);
x1 = (d1-140)./40; x2 = (d2-50)./20; x3 = (d3-30)/10;
x = [x1 x2 x3];

% Save the coded variables and the average flight time to an excel file
full3factorial = array2table([x, t_ave], 'VariableNames', {'x1', 'x2', 'x3', 'Flight Time'});
filename = 'FullFactorial.xlsx';
writetable(full3factorial,filename, 'Sheet', '1');

X = [ones(size(x,1),1), x];
b = (X'*X)^(-1)*X'*y;

% Sum of Squares
y_hat = b(1)+ x*b(2:end);
SST = sum((y-mean(y)).^2);
SSE = sum((y-y_hat).^2);
SSR = sum((y_hat-mean(y)).^2);

% Mean Sum of Squares
k = length(b)-1; n = size(X,1);
MST = SST/(n-1);
MSR = SSR/(k);
MSE = SSE/(n-k-1);

% Significance of regression
Fo = MSR/MSE;             %F-test

R2 = 1 - SSE/SST;
Radj2 = 1 - MSE/MST;

std = sqrt(SSE/(n-k-1));

C_ii = diag((X'*X)^-1);

st_error = std*sqrt(C_ii); %standard error

t_o = abs(b)./st_error;   %t-test


%Result Output

fprintf('b = {')
fprintf('%f, ',b)
fprintf('}\n')
fprintf('\n');

fprintf('SS_T = %f, SSE_E = %f, SS_R = %f\n', SST, SSE, SSR)
fprintf('MS_T = %f, MSE_E = %f, MS_R = %f\n', MST, MSE, MSR)
fprintf('\n');

fprintf('Fo = %f\n', Fo);
F_ref = 3.03;
if Fo > F_ref
    fprintf('F-Test Passed. Regression model is 95 percent significant.\n');
else
    fprintf('Fo < F_ref = %f. F-Test failed! Regression model is not 95 percent significant.\n', F_ref);
end
fprintf('\n');

fprintf('R^2 = %f\n', R2);
fprintf('Radj^2 = %f\n', Radj2);
fprintf('sigma = %f\n', std);
fprintf('\n');

fprintf('t_o = {')
fprintf('%f, ',t_o)
fprintf('} for (b0, b1, b2, b3)\n')
fprintf('\n');
t_ref = 2.069;
for count=1:length(t_o)
    if t_o(count)< t_ref
        fprintf("!! t_o of b(%d) = %f is less than t_ref = %f !!\n", count-1 ,t_o(count), t_ref);
    end
end
























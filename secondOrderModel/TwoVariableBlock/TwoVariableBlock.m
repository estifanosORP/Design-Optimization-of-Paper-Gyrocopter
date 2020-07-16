clear all; clc
data = [-1	-1	0	5.17;
    -1	1	0	6.98;
    1	-1	0	5.56;
    1	1	0	8.21;
    -1	0	-1	7.02;
    -1	0	1	6.46;
    1	0	-1	6.85;
    1	0	1	6.94;
    0	-1	-1	6.48;
    0	-1	1	5.21;
    0	1	-1	8.92;
    0	1	1	8.39;
    0	0	0	8.19];

% Save the coded variables and the average flight time to an excel file
twovariableblock = array2table(data, 'VariableNames', {'x1', 'x2', 'x3', 'Flight Time'});
filename = 'TwoVariable.xlsx';
writetable(twovariableblock,filename, 'Sheet', '1');

%coded variable
x1 = data(:,1);  x2 = data(:,2); x3 = data(:,3);
x = [x1, x2, x3];
y = data(:,4);

X = [ones(size(x,1),1), x, x1.*x2, x1.*x3, x2.*x3, x1.^2, x2.^2, x3.^2];
b = (X'*X)^(-1)*X'*y;

% Sum of Squares
y_hat = b(1)+ X(:,2:end)*b(2:end);
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
F_ref = 8.81;
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
fprintf('} for (b0, b1, b2, b3, b4 b5, b6, b7, b8, b9)\n')
fprintf('\n');
t_ref = 3.182;
for count=1:length(t_o)
    if t_o(count)< t_ref
        fprintf("!! t_o of b(%d) = %f is less than t_ref = %f !!\n", count-1 ,t_o(count), t_ref);
    end
end

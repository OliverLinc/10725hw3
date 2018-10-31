function [alpha, beta, beta_0] = train_svm(X, y, gamma, C)
%TRAIN_SVM Train svm with data X and y, parameter gamma and C
%   Returns alpha, beta, beta_0 for gamma and C
shape = size(X);
n = shape(1);
p = shape(2);
X2 = sum(X.^2, 2);
K = bsxfun(@plus, X2, bsxfun(@plus, X2', - 2 * (X * X')));
K = rbf_kernel(1, 0, gamma) .^ K;

H = diag(y)*K*diag(y);
f = -ones(n, 1);
Aeq = y';
beq = 0;
lb = zeros(n,1);
ub = C*ones(n,1);
A = [];
b = [];
x0 = [];

[alpha,fval,~,~,~] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0);
fprintf('gamma=%f, C=%f, optimal values=%f', gamma, C, fval);

beta = X'*(alpha.*y);

sv_index = alpha>1e-5;
y_sv = y(sv_index,:);
x_sv = X(sv_index,:);

sv = alpha(sv_index);
c_idx = sv<C-1e-5;
x_c = x_sv(c_idx,:);
y_c = y_sv(c_idx,:);

beta_0 = y_c(1) - dot(x_c(1,:), beta);
end


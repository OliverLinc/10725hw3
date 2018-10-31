function [w, beta, beta_0, obj] = ...
    train_svm_barrier(X, y, gamma, C, mu, alpha, step_beta, epsilon)
%TRAIN_SVM_BARRIER Train SVM with barrier method
%   X, y: train data
%   gamma: parameter in RBF kernel
%   C: 0<=w<=C
%   mu: Barrier method parameter, recommended 1000
%   alpha: backtracking parameter
%   step_beta: backtracking
%   epsilon: precision at eta and norm of r
TOL = 1e-5;

shape = size(X);
n = shape(1);
p = shape(2);
X2 = sum(X.^2, 2);
K = bsxfun(@plus, X2, bsxfun(@plus, X2', - 2 * (X * X')));
K = rbf_kernel(1, 0, gamma) .^ K;

H = diag(y)*K*diag(y);

u = rand(n, 1);
v = rand(n, 1);
lambda = rand(1,1);

w = find_strict_feasible(y, C);

eta = -[-w; w-C]' * [u; v];
t = mu * 2 * n / eta;

iter = 0;
obj_list = [];
while (1)
    iter = iter + 1;
    G = diag(u./w + v./(C-w));
    Q = H + G;
    
    z = - H*w + 1 - lambda * y + 1/t*(1./w-1./(C-w));
    temp = inv(Q);

    Delta_lambda = (y'*temp*z + y'*w)/(y'*temp*y);
    Delta_w = temp*(z-y*Delta_lambda);
    Delta_u = -u + 1/t*1./w - diag(u./w) * Delta_w;
    Delta_v = -v + 1/t*1./(C-w) + diag(v./(C-w))*Delta_w;
    
    % backtracking to determine step size t

    step_t = backtrack_step(w,u,v,lambda,...
        Delta_w,Delta_u,Delta_v,Delta_lambda,H,y,t,C,alpha,step_beta);
    
    % update u,v,w,lambda
    u = u + step_t * Delta_u;
    v = v + step_t * Delta_v;
    w = w + step_t * Delta_w;
    lambda = lambda + step_t * Delta_lambda;
    
    eta = -[-w; w-C]' * [u; v];
    t = mu * 2 * n / eta;
    r_prim = y'*w;
    r_dual = H * w - 1 - u + v + lambda * y;
    norm_rr = sqrt(norm(r_prim)^2 + norm(r_dual)^2);
    
    if (eta <= epsilon && norm_rr <= epsilon)
        break;
    end
    fprintf("Iteration %d:\n", iter);
    fprintf("eta: %f\n", eta);
    fprintf("Log barrier obj:%f\n", log_barrier_obj(H, t, w, C));
    obj = 1/2*w'*H*w-sum(w);
    fprintf("Obj:%f\n", obj);
    obj_list = [obj_list, obj];
end

beta = X'*(w.*y);

sv_index = w>TOL;
y_sv = y(sv_index,:);
x_sv = X(sv_index,:);

sv = w(sv_index);
c_idx = sv<C-TOL;
x_c = x_sv(c_idx,:);
y_c = y_sv(c_idx,:);

beta_0 = y_c(1) - dot(x_c(1,:), beta);

plot(1:length(obj_list), obj_list)
xlabel("Iteration");
ylabel('$$\frac{1}{2}w^T\tilde{K}w-\mathbf{1}^Tw$$', 'Interpreter', 'latex');
title("Objective value vs. iterations");


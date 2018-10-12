function [flag] = predict_svm(samples, X, y, gamma, C, alpha, beta, beta_0)
%PREDICT_SVM Predict class of samples with trained data and parameters
%   samples is a m*p matrix, each row is a sample
%   returns a m*1 vector, each row is the class for the sample
shape = size(X);
n = shape(1);

shape = size(samples);
n_sample = shape(1);

flag = zeros(n_sample,1);

X1 = sum(samples.^2, 2);
X2 = sum(X.^2, 2)';
K = bsxfun(@plus, X1, bsxfun(@plus, X2, -2*samples*X'));
K = rbf_kernel(1, 0, gamma) .^ K;
K = bsxfun(@times, y', K);
K = bsxfun(@times, alpha, K);
vals = sum(K, 2);

flag(vals>=0) = 1;
flag(vals<0) = -1;

end


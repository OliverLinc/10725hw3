function [error, error_pos, error_neg] =...
    classification_error(x_train, y_train, gamma, C, alpha, beta, beta_0)
%CLASSIFICATION_ERROR Compute classifcation error and FP, FN error on tra
shape=size(x_train);
n=shape(1);
y_pred = predict_svm(x_train, x_train, y_train, ...
    gamma, C, alpha, beta, beta_0);
err = find(y_pred ~= y_train);
error = length(err)/n;

N = find(y_train==-1);
P = find(y_train==1);
FP = find(y_pred(err)==1);
FN = find(y_pred(err)==-1);

error_pos = length(FP)/length(N);
error_neg = length(FN)/length(P);
end


function [num_sv] = ...
    find_support_vectors(x_train, y_train, gamma, C, alpha, beta, beta_0)
%FIND_SUPPORT_VECTORS Find support vectors and paint them green
%   Input: training data and model
%   Output: number of support vectors and the gr
x1plot = linspace(min(x_train(:,1)), max(x_train(:,1)), 100)';
x2plot = linspace(min(x_train(:,2)), max(x_train(:,2)), 100)';
[X1, X2] = meshgrid(x1plot, x2plot);
vals = zeros(size(X1));
for i = 1:size(X1, 2)
   this_X = [X1(:, i), X2(:, i)];
   vals(:, i) = predict_svm(this_X, x_train, y_train, ...
       gamma, C, alpha, beta, beta_0);
end

pos = find(alpha > 1e-5);
num_sv = length(pos);
fprintf('gamma=%d, C=%.2f, num of support vectors: %d', gamma, C, num_sv);
plot(x_train(pos, 1), x_train(pos, 2), 'gs','LineWidth', 1,'MarkerSize', 7)
hold on;

figname = sprintf('./output/sv/sv_gamma_%d_C_%d.png', gamma, 100*C);

plot_raw(x_train, y_train, 0);
hold on
contour(X1, X2, vals, [1 1], 'r');
hold on
xlabel('Feature 1')
ylabel('Feature 2')
title(...
    sprintf(...
    'Classifcation boundary and support vectors gamma=%d C=%.2f', ...
    gamma, C));
saveas(gca, figname, 'png');

hold off;
end


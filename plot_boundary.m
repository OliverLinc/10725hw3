function plot_boundary(x_train, y_train, gamma, C, alpha, beta, beta_0)
%PLOT_BOUNDARY Plot the boundary by alpha, beta, beta_0 on training data

x1plot = linspace(min(x_train(:,1)), max(x_train(:,1)), 100)';
x2plot = linspace(min(x_train(:,2)), max(x_train(:,2)), 100)';
[X1, X2] = meshgrid(x1plot, x2plot);
vals = zeros(size(X1));
for i = 1:size(X1, 2)
   this_X = [X1(:, i), X2(:, i)];
   vals(:, i) = predict_svm(this_X, x_train, y_train, ...
       gamma, C, alpha, beta, beta_0);
end

figname = sprintf('./output/boundary/boundary_gamma_%d_C_%d.png', ...
    gamma, 100*C);

plot_raw(x_train, y_train, 1);
hold on
contour(X1, X2, vals, [1 1], 'r');
xlabel('Feature 1')
ylabel('Feature 2')
title(sprintf('Classifcation boundary gamma=%d C=%.2f', gamma, C));
saveas(gca, figname, 'png');

hold off;
end


function plot_raw(X, y, color)
%PLOT_RAW plot X and y
%   If color==1, set positive sample blue

    pos = find(y == 1);
    neg = find(y == -1);
    
    plot(X(pos, 1), X(pos, 2), 'k+','LineWidth', 1, 'MarkerSize', 5)
    hold on;
    if (color == 1)
        plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'b',...
            'MarkerSize', 5)
    else
        plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerSize', 5)
    hold off;
    
    end
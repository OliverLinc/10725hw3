function [w] = find_strict_feasible(y, C)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

n = length(y);

num_positive = sum(y>0);
num_negative = sum(y<0);

negative = C/2*min(1,num_positive/num_negative);
positive = num_negative * negative / num_positive;

w = ones(n, 1) * negative;

for i=1:n
    if (y(i) > 0)
        w(i) = positive;
    end
end

end


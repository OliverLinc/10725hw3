function [num_sv] = ...
    find_sv_num(alpha)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
pos = find(alpha > 1e-5);
num_sv = length(pos);
end


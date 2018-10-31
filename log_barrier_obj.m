function [f] = log_barrier_obj(H,t,w,C)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
f = t*(1/2*w'*H*w - sum(w)) - sum(log(C-w)) - sum(log(w));
end


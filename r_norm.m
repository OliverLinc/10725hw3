function [v] = r_norm(w,u,v,lambda,H,y,t,C)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
r_dual = -(H*w-1-u+v+lambda*y);
r_cent = -[diag(u)*w-1/t;-diag(v)*(w-C)-1/t];
r_prim = -y'*w;
r = [r_dual; r_cent; r_prim];
v = norm(r);
end


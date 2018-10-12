function val = rbf_kernel(x1, x2, gamma)

x1 = x1(:);
x2 = x2(:);

val = exp(-gamma*sum((x1-x2).^2));
    
end

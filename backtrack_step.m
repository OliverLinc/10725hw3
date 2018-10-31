function [step_t] = ...
backtrack_step(w,u,v,lambda,Delta_w,Delta_u,Delta_v,Delta_lambda,H,y,t,C,alpha,step_beta)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
positive_Delta_u = Delta_u;
positive_Delta_u(Delta_u>0) = -u(Delta_u>0);
positive_Delta_v = Delta_v;
positive_Delta_v(Delta_v>0) = -v(Delta_v>0);

step_t = 0.99 * min([1, ...
                    min(-u./positive_Delta_u), ...
                    min(-v./positive_Delta_v)]);

r_current = r_norm(w, u, v,lambda, H, y, t, C);
while (1)
    w_temp = w + step_t * Delta_w;
    u_temp = u + step_t * Delta_u;
    v_temp = v + step_t * Delta_v;
    lambda_temp = lambda + step_t * Delta_lambda;
    r_temp = r_norm(w_temp, u_temp, v_temp, lambda_temp, H, y, t, C);

    if (sum([-w_temp; w_temp-C]>=0) == 0 && r_temp<=(1-alpha*step_t)*r_current)
        break;
    end
    step_t = step_beta*step_t;
end
end


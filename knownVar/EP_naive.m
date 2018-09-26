%% Envelope procedure with Known Variances
% 1 sample for each system
n0 = bsize;

eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma .* eta ./ sqrt(n); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
XUb = Xbar + d;
[max_ub, max_ub_i] = max(XUb(others));
max_ub_i = others(max_ub_i);
counter = 0;
maxis = 0;
maxubis = 0;
N = (2*eta*max(sigma)/delta)^2;

while max_ub - ( max_x - d(max_i) ) > delta 
    counter = counter + 1;
    n_add = ones(1, k) * bsize;
    
    maxis(counter) = max_i;
    maxubis(counter) = max_ub_i;
    %n_tmp(max_i) - n(max_i)
        
    X_add = genSample(1, mu .* n_add, sigma .* sqrt(n_add));
    Xbar = (Xbar .* n + X_add) ./ (n + n_add);
    n = n + n_add;
    d = sigma .* eta ./ sqrt(n);
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
    if max(n) > N
        break
    end
end
max_i;
sum(n);
    
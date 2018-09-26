%% New procedure with Known Variances
% b1 = B / 2(greedy2)

% Based on algo4
delta;
alpha;
B = bsize * 2;
b = bsize;
n0 = bsize;

a = (1-(1-alpha)^(1/k));
eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma1 * eta ./ sqrt(n); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
[max_ub, max_ub_i] = max(Xbar(others) + d(others));
max_ub_i = others(max_ub_i);

while max_ub - ( max_x - d(max_i) ) > delta 
    b1 = B / 2;
    n_tmp = n;
    n_tmp(max_i) = n_tmp(max_i) + b1;
    d_tmp = sigma1 * eta ./ sqrt(n_tmp);
    for ib = b:b:B-b1
        [max_ub, max_ub_i] = max(Xbar(others) + d_tmp(others));
        max_ub_i = others(max_ub_i);
        n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        d_tmp(max_ub_i) = sigma1 * eta ./ sqrt(n_tmp(max_ub_i));
    end
        
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    d = sigma1 * eta ./ sqrt(n);
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    [max_ub, max_ub_i] = max(Xbar(others) + d(others));
    max_ub_i = others(max_ub_i);
end
max_i;
sum(n);
    
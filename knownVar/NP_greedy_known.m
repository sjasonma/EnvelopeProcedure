%% New procedure with Known Variances
% Enumerate b1 (greedy)

% Based on algo4
delta;
alpha;
B = bsize * 10;
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
counter = 0;
n_maxi_inc = 0;
maxis = 0;

while max_ub - ( max_x - d(max_i) ) > delta 
    counter = counter + 1;
    min_diff = inf;
    for b1 = b:b:B
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + b1;
        d_tmp = sigma1 * eta ./ sqrt(n_tmp);
        for ib = b:b:B-b1
            [max_ub, max_ub_i] = max(Xbar(others) + d_tmp(others));
            max_ub_i = others(max_ub_i);
            n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
            d_tmp(max_ub_i) = sigma1 * eta ./ sqrt(n_tmp(max_ub_i));
        end
        [max_ub, max_ub_i] = max(Xbar(others) + d_tmp(others));
        max_ub_i = others(max_ub_i);
        if max_ub - ( max_x - d_tmp(max_i) ) < min_diff
            min_diff = max_ub - ( max_x - d_tmp(max_i) );
            min_diff_n_tmp = n_tmp;
        end
    end
    n_tmp = min_diff_n_tmp;
    n_maxi_inc(counter) = n_tmp(max_i) - n(max_i);
    maxis(counter) = max_i;
        
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
    
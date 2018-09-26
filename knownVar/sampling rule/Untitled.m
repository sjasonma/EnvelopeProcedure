%% Envelope procedure with Known Variances
% Enumerate b1 (greedy)
% optimized based on NP_greedy_known

% Based on algo3
delta;
alpha;
B = bsize * 20;
b = bsize;
n0 = bsize;

a = (1-(1-alpha)^(1/k));
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
n_maxi_inc = 0;
maxis = 0;

while max_ub - ( max_x - d(max_i) ) > delta 
    counter = counter + 1;
    
    sigma_n = sqrt(1 ./ (1 ./ (sigma0.^2) + n ./ (sigma.^2)));
    mu_n = sigma_n.^2 .* (mu0 ./ (sigma0.^2) + n .* Xbar ./ (sigma.^2));

    N_gen = 100;
    obj_val = zeros(n_alloc_comb, N_gen);
    for i_gen = 1:N_gen
        Xboost = genSample(bn, mu_n, sqrt(sigma_n.^2 + sigma.^2) / sqrt(bsize));
        Xbar_boost = (repmat(Xbar.*n, [(bn+1), 1]) + cumsum([zeros(1, k); Xboost] * bsize)  ) ./ (repmat(n, [(bn+1), 1]) + repmat((0:bn)'*bsize, [1, k]));
        d_boost = repmat(eta * sigma, [(bn+1), 1]) ./ sqrt((repmat(n, [(bn+1), 1]) + repmat((0:bn)'*10, [1, k])));
        U_boost = Xbar_boost + d_boost;
        for i_alloc = 1:n_alloc_comb
            idx = alloc(i_alloc, :) + [0:(k-1)]*(bn+1) + 1;
            Xbar_boost_tmp = Xbar_boost(idx);
            U_boost_tmp = U_boost(idx);
            [max_x, max_i] = max(Xbar_boost_tmp);
            others = setdiff(1:k, max_i)';
            [max_ub, max_ub_i] = max(U_boost_tmp(others));
            max_ub_i = others(max_ub_i);
            obj_val(i_alloc, i_gen) = max_ub - ( max_x - d_boost(idx(max_i)) );
        end
    end
    [opt_obj, opt_alloc_i] = min(mean(obj_val, 2));
    opt_alloc = alloc(opt_alloc_i, :) * bsize
    n_tmp = n + opt_alloc;
        
    n_tmp - n;
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    d = sigma .* eta ./ sqrt(n);
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
end
max_i;
sum(n);
    
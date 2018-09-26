mu0 = 0; sigma0 = 0.1;

bn = 5;
B = bsize * bn;
b = bsize;

n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));

sigma_n = sqrt(1 ./ (1 ./ (sigma0.^2) + n ./ (sigma.^2)));
mu_n = sigma_n.^2 .* (mu0 ./ (sigma0.^2) + n .* Xbar ./ (sigma.^2));

Xboost = genSample(B, mu_n, sqrt(sigma_n.^2 + sigma.^2));
Xboost = genSample(B, mu_n, sqrt(sigma_n.^2));

pm = zeros(1, k);
for i = 1:k
    pdfi = @(x) normpdf(x, mu_n(i), sigma_n(i));
    cdfj = @(x) 1;
    for j = 1:k
        if i == j
            continue
        end
        cdfj = @(x) cdfj(x) .* normcdf(x, mu_n(j), sigma_n(j));
    end
    pm(i) = integral(@(x) cdfj(x).*pdfi(x), -inf, inf );
end

% Xbar
Xbar_boost = (repmat(Xbar.*n, [B, 1]) + cumsum(Xboost) ) ./ (repmat(n, [B, 1]) + repmat((1:B)', [1, k]))
% Xbar + genSample(1, mu, sigma/sqrt(n0))
d_boost = repmat(eta * sigma, [B, 1]) ./ sqrt(repmat(n, [B, 1]) + repmat((1:B)', [1, k]));
U_boost = Xbar_boost + d_boost
L_boost = Xbar_boost - d_boost

n_alloc_comb = nchoosek((bn+(k-1)), (k-1));
alloc_comb = combnk(1:(bn+(k-1)), (k-1));
alloc = zeros(n_alloc_comb, k);
for alloc_i = 1:(k-1)
    alloc(:, alloc_i) = alloc_comb(:, alloc_i) - alloc_i;
end
for alloc_i = (k-1):-1:2
    alloc(:, alloc_i) = alloc(:, alloc_i) - alloc(:, alloc_i-1);
end
alloc(:, k) = bn - sum(alloc(:, (1:k-1)), 2);

%%%
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
opt_obj
    


%% BIZ w/ known variance 
delta;
alpha;
bsize;
n0 = bsize;

a = 1 - (1-alpha)^(1/(k-1)); % c in paper
sigma2 = sigma.^2;

idx = 1:k; % index set of survivors
t = n0;
n = ones(1, k) * n0;
W = genSample(1, mu*n0, sigma*sqrt(n0)); % sum of X_ij
P = 1 - alpha;
beta_t = sum(n(idx)) / sum(sigma2(idx));
q = delta * beta_t .* W ./ n;
q = q - min(q);
q = exp(q);
q = q / sum(q);

while max(q(idx)) < P
    idx_elim = find(q(idx) <= a);
    P = P / (prod(1 - q(idx(idx_elim))));
    idx(idx_elim) = [];
    
    [min_z, z] = min(n(idx) ./ sigma2(idx));
    z = idx(z);
    n_new = ceil(sigma2(idx) * (n(z) + bsize) / sigma2(z));
    n_add = max(0, n_new - n(idx));
    W(idx) = W(idx) + genSample(1, mu(idx).* n_add, sigma(idx).*sqrt(n_add));
    n(idx) = n(idx) + n_add;
    t = t + 1;
    
    beta_t = sum(n(idx)) / sum(sigma2(idx));
    q(idx) = delta * beta_t .* W(idx) ./ n(idx);
    q(idx) = q(idx) - max(q(idx));
    q(idx) = exp(q(idx));
    q(idx) = q(idx) / sum(q(idx));
end
[max_x, max_i] = max(W(idx) ./ n(idx));
max_i = idx(max_i);
sum(n);
        
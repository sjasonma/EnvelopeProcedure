% KN with known common variance
delta;
alpha;
bsize;
n0 = bsize;

eta = -log(2 * alpha / (k-1));
h2 = 2 * 1 * eta;
h2S2_d2 = h2 * 2 * sigma(1)^2 / delta^2;

idx = 1:k; % index set of survivors
t = n0; % r in paper
n = ones(1, k) * n0;
Y = genSample(1, mu*n0, sigma*sqrt(n0)); % sum of X_ij

c_n_iter = 1;

while length(idx) > 1
    max_x = max(Y(idx));
    Wt = max(0, delta / 2 * (h2S2_d2 - t)); % W * t
    idx_elim = find(Y(idx) < max_x - Wt);
    idx(idx_elim) = [];
    
    Y(idx) = Y(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
    n(idx) = n(idx) + bsize;
    t = t + bsize;
    
    [max_x, max_i] = max(Y(idx));
    max_i = idx(max_i);
    c_n_iter2 = floor(sum(n) / unit);
    if c_n_t(c_n_iter2) == -1
        if max_i == 1
            c_n_t(c_n_iter: c_n_iter2) = 1;
        else
            c_n_t(c_n_iter: c_n_iter2) = 0;
        end
        c_n_iter = c_n_iter2 + 1;
    end
end
max_i = idx(1);

if max_i == 1
    c_n_t(c_n_iter2:end) = 1;
else
    c_n_t(c_n_iter2:end) = 0;
end
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

while length(idx) > 1
    max_x = max(Y(idx));
    Wt = max(0, delta / 2 * (h2S2_d2 - t)); % W * t
    idx_elim = find(Y(idx) < max_x - Wt);
    idx(idx_elim) = [];
    
    Y(idx) = Y(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
    n(idx) = n(idx) + bsize;
    t = t + bsize;
end
max_i = idx(1);
sum(n);
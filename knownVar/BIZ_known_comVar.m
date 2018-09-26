%% BIZ w/ known common variance 
delta;
alpha;
bsize;
n0 = bsize;

a = 1 - (1-alpha)^(1/(k-1)); % c in paper
sigma2 = sigma(1)^2;

idx = 1:k; % index set of survivors
t = n0;
n = ones(1, k) * n0;
Y = genSample(1, mu*n0, sigma*sqrt(n0)); % sum of X_ij
P = 1 - alpha;
q = delta / sigma2 * Y;
q = q - min(q);
q = exp(q);
q = q / sum(q);

while max(q(idx)) < P
    idx_elim = find(q(idx) <= a);
    P = P / (prod(1 - q(idx(idx_elim))));
    idx(idx_elim) = [];
    
    Y(idx) = Y(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
    n(idx) = n(idx) + bsize;
    t = t + 1;
    
    q(idx) = delta / sigma2 * Y(idx);
    q(idx) = q(idx) - max(q(idx));
    q(idx) = exp(q(idx));
    q(idx) = q(idx) / sum(q(idx));
end
[max_q, max_i] = max(q(idx));
max_i = idx(max_i);
sum(n);
        
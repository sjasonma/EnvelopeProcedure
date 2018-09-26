% BIZ with unknown variances
function [max_i, n] = algo_BIZ_unknown(mu, sigma, delta, alpha, bsize, n0)
k = length(mu);
a = 1 - (1-alpha)^(1/(k-1));
idx = 1:k; % index set of survivors

t = 0;
n = ones(1, k) * n0;
[W, W2] = genSamples(n0*ones(1, k), k, mu, sigma);
S2 = (W2 - W.^2 ./n) ./ (n-1); % lambda in the paper
P = 1 - alpha;
beta_t = sum(n(idx)) / sum(S2(idx));
q = delta * beta_t .* W ./ n;
q = q - min(q);
q = exp(q);
q = q / sum(q);

while max(q(idx)) < P
    idx_elim = find(q(idx) <= a);
    P = P / (prod(1 - q(idx(idx_elim))));
    idx(idx_elim) = [];
    
    [min_z, z] = min(n(idx) ./ S2(idx));
    z = idx(z);
    n_new = ceil(S2(idx) * (n(z) + bsize) / S2(z));
    n_add = max(0, n_new - n(idx));
    [W_add, W2_add] = genSamples(n_add, length(idx), mu(idx), sigma(idx));
    W(idx) = W(idx) + W_add;
    W2(idx) = W2(idx) + W2_add;
    n(idx) = n(idx) + n_add;
    S2(idx) = (W2(idx) - W(idx).^2 ./n(idx)) ./ (n(idx)-1);
    t = t + 1;
    
    beta_t = sum(n(idx)) / sum(S2(idx));
    q(idx) = delta * beta_t .* W(idx) ./ n(idx);
    q(idx) = q(idx) - max(q(idx));
    q(idx) = exp(q(idx));
    q(idx) = q(idx) / sum(q(idx));
end
[max_x, max_i] = max(W(idx) ./ n(idx));
max_i = idx(max_i);

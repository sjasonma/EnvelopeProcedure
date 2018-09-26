% KN with unknown variances
% Save all of S^2 (k * k), so requires large memory.
function [max_i, n] = algo_KN_unknown_largeMemory(mu, sigma, delta, alpha, bsize, n0)
genSample = @(n, mu, sigma) randn(n, length(mu)) .* repmat(sigma, [n, 1]) + repmat(mu, [n, 1]);
k = length(mu);
eta = 1 / 2 * ((2 * alpha / (k - 1))^(-2 / (n0 - 1)) - 1);
h2 = 2 * eta * (n0 - 1);

idx = 1:k; % index set of survivors

X = genSample(n0, mu, sigma);
Xsum = sum(X);
for i = 1 : k
    S2(i, :) =  var(repmat(X(:,i), [1, k]) - X);
    Ni(i) = max(floor(h2 * S2(i, :) / delta^2));
end
max_N = max(Ni);

t = n0; % r in paper
n = ones(1, k) * t;
if n0 > max_N
    [max_x, max_i] = max(Xsum);
end

while length(idx) > 1
    idx_elim = false(size(idx));
    for sys_l = idx
        %???  rW = max(0, h2 * (sigma(sys_l)^2 + sigma(idx).^2) / 2 / delta - delta * t / 2);
        rW = max(0, h2 * S2(sys_l, idx) / (2 * delta) - delta * t / 2);
        idx_elim = idx_elim | ( Xsum(idx) + 1e-8 < Xsum(sys_l) - rW );
    end
    idx(idx_elim) = [];
    
    Xsum(idx) = Xsum(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
    n(idx) = n(idx) + bsize;
    t = t + bsize;
end
max_i = idx(1);
sum(n);
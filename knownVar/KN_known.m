% KN with known variances
delta;
alpha;
bsize;
n0 = bsize;

eta = -log(2 * alpha / (k-1));
h2 = 2 * 1 * eta;

idx = 1:k; % index set of survivors
t = n0; % r in paper
n = ones(1, k) * n0;
Y = genSample(1, mu*n0, sigma*sqrt(n0)); % sum of X_ij

while length(idx) > 1
    idx_elim = false(size(idx));
    for sys_l = idx
        rW = max(0, h2 * (sigma(sys_l)^2 + sigma(idx).^2) / 2 / delta - delta * t / 2);
        idx_elim = idx_elim | ( Y(idx) + 1e-8 < Y(sys_l) - rW );
    end
    idx(idx_elim) = [];    
%     [max_x, max_i] = max(Y(idx));
%     h2S2_d2 = h2 *  sigma(idx).^2 / 2 / delta;
%     idx_elim = find(Y(idx) + h2S2_d2 < max(Y(idx) - h2S2_d2 + delta * t / 2));
%     if length(idx_elim) == length(idx)
%         idx = idx(max_i);
%     else
%         idx(idx_elim) = [];
%     end
    
    Y(idx) = Y(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
    n(idx) = n(idx) + bsize;
    t = t + bsize;
end
max_i = idx(1);
sum(n);
% GSP with known variances
delta;
alpha;
bsize;
n0 = bsize;

maxk = 10;
rbar = 20;
alpha1 = alpha / 2;
alpha2 = alpha / 2;
eta = norminv(1/2 + (1-alpha1)^(1/(k-1))/2);
h_delta2 = h^2 / delta^2;

bs = ceil(bsize * sigma / mean(sigma));

% idx = 1:k; % index set of survivors
% t = n0; % r in paper
% n = ones(1, k) * n0;
% Y = genSample(1, mu*n0, sigma*sqrt(n0)); % sum of X_ij
% 
% while length(idx) > 1
%     [max_x, max_i] = max(Y(idx));
%     h2S2_d2 = h2 *  sigma(idx).^2 / 2 / delta;
%     idx_elim = find(Y(idx) + h2S2_d2 < max(Y(idx) - h2S2_d2 + delta * t / 2));
%     if length(idx_elim) == length(idx)
%         idx = idx(max_i);
%     else
%         idx(idx_elim) = [];
%     end
%     
%     Y(idx) = Y(idx) + genSample(1, mu(idx)*bsize, sigma(idx)*sqrt(bsize));
%     n(idx) = n(idx) + bsize;
%     t = t + bsize;
% end
% max_i = idx(1);
% sum(n);
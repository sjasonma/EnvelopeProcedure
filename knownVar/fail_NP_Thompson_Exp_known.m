%% New procedure with Known Variances
% choose samples according to the posterior distribution
% similar to BIZ in computing the posterior distribution
% Seems failed. Too large n.

delta;
alpha;
bsize;
n0 = bsize;

a = (1-(1-alpha)^(1/k));
eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma1 * eta ./ sqrt(n); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
[max_ub, max_ub_i] = max(Xbar(others) + d(others));
max_ub_i = others(max_ub_i);

while max_ub - ( max_x - d(max_i) ) > delta 
    q = delta / sigma1^2 * Xbar .* n - delta^2 / 2 / sigma1^2 * n;
    q = exp(q - max(q));
    q = q / sum(q);
    %% choose samples according to the distribution with pmf q.
    r = rand(1, bsize);
    n_add = histc(r,cumsum(q));
        
    X_add = genSample(1, mu .* n_add, sigma .* sqrt(n_add));
    Xbar = (Xbar .* n + X_add) ./ (n + n_add);
    n = n + n_add;
    d = sigma1 * eta ./ sqrt(n);
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    [max_ub, max_ub_i] = max(Xbar(others) + d(others));
    max_ub_i = others(max_ub_i);
end
max_i;
sum(n);
    
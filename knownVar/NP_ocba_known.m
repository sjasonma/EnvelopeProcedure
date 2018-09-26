%% New procedure with Known Variances
% OCBA for allocation rule

% Based on algo4
delta;
alpha;
B = bsize * 10;
n0;

a = (1-(1-alpha)^(1/k));
eta = 4.3;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
n_total = n0 * k;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma1 * eta ./ sqrt(n); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
[max_ub, max_ub_i] = max(Xbar(others) + d(others));
max_ub_i = others(max_ub_i);

while max_ub - ( max_x - d(max_i) ) > delta 
    n_ratio = 1 ./ (max_x - Xbar) .^2;
    n_ratio(max_i) = sqrt(sum(n_ratio([1:(max_i-1), (max_i+1):end]).^2));
    n_ratio = n_ratio / sum(n_ratio);
    
    left_p = 1; right_p = n_total + B;
    mid_p = (left_p + right_p) / 2;
    n_add_total = sum(ceil(max(0, n_ratio * mid_p - n)));
    while n_add_total > 2 * B || n_add_total < B / 2
        if n_add_total > 2 * B
            right_p = mid_p;
        else
            left_p = mid_p;
        end
        mid_p = (left_p + right_p) / 2;
        n_add_total = sum(ceil(max(0, n_ratio * mid_p - n)));
    end
    n_tmp = ceil(max(n, n_ratio * mid_p));
        
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    n_total = sum(n);
    d = sigma1 * eta ./ sqrt(n);
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    [max_ub, max_ub_i] = max(Xbar(others) + d(others));
    max_ub_i = others(max_ub_i);
end
max_i
sum(n)
    
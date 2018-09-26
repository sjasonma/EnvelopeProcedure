% Known Variances
% Enumerate b1
% New stopping rule (WRONG)

Mu;
Sigma;
k = length(Mu);
n1 = 10;

alpha;
delta;
B = 100;
b = B / 10;
eta = -norminv( alpha / 2, 0, 1);

n = n1 * ones(k, 1);
Xbar = randn(k, 1) .* Sigma / sqrt(n1) + Mu;
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
bound = max_x - Sigma(max_i)*eta/sqrt(n(max_i)) + delta;
log_prob_under = log(1 - normcdf(Xbar(others), bound, Sigma(others)./sqrt(n(others))));
total_log_prob = sum(log_prob_under);

counter = 0;
while total_log_prob < log(1-alpha/2)
    counter = counter + 1;
    max_sum = total_log_prob;
    for b1 = b:b:B
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + b1;
        for ib = b:b:B-b1
            [min_log_prob, min_log_prob_i] = min(log(1 - normcdf(Xbar(others), bound, Sigma(others)./sqrt(n_tmp(others)))));
            min_log_prob_i = others(min_log_prob_i);
            n_tmp(min_log_prob_i) = n_tmp(min_log_prob_i) + b;
        end
        bound = max_x - Sigma(max_i)*eta/sqrt(n_tmp(max_i)) + delta;
        log_prob_under = log(1 - normcdf(Xbar(others), bound, Sigma(others)./sqrt(n_tmp(others))));
        total_log_prob = sum(log_prob_under);
        if total_log_prob > max_sum
            max_sum = total_log_prob;
            max_sum_n_tmp = n_tmp;
            max_sum_b1 = b1;
        end
    end
    n_tmp = max_sum_n_tmp;
        
    Xbar_add = randn(k, 1) .* Sigma ./ sqrt(n_tmp - n) + Mu;
    Xbar_add(n_tmp==n) = 0;
    Xbar = (Xbar .* n + Xbar_add .* (n_tmp - n)) ./ (n_tmp);
    n = n_tmp;
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    
    bound = max_x - Sigma(max_i)*eta/sqrt(n(max_i)) + delta;
    log_prob_under = log(1 - normcdf(Xbar(others), bound, Sigma(others)./sqrt(n(others))));
    total_log_prob = sum(log_prob_under);
    
    
end
    
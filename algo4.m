% Known Variances
% Enumerate b1

Mu;
Sigma;
k = length(Mu);
n1 = 10;

alpha;
delta;
B = 100;
b = B / 10;
a = (1-(1-alpha)^(1/k));
eta = -norminv( a / 2, 0, 1);
eta = 4.3;

n = n1 * ones(k, 1);
Xbar = randn(k, 1) .* Sigma / sqrt(n1) + Mu;
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
[max_ub, max_ub_i] = max(Xbar(others) + Sigma(others)*eta./sqrt(n(others)));
max_ub_i = others(max_ub_i);
n_tmp = n;

counter = 0;
while max_ub - ( max_x - Sigma(max_i)*eta/sqrt(n(max_i)) ) > delta 
    counter = counter + 1;
    min_diff = inf;
    for b1 = b:b:B
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + b1;
        for ib = b:b:B-b1
            [max_ub, max_ub_i] = max(Xbar(others) + Sigma(others)*eta./sqrt(n_tmp(others)));
            max_ub_i = others(max_ub_i);
            n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        end
        [max_ub, max_ub_i] = max(Xbar(others) + Sigma(others)*eta./sqrt(n_tmp(others)));
        max_ub_i = others(max_ub_i);
        if max_ub - ( max_x - Sigma(max_i)*eta/sqrt(n_tmp(max_i)) ) < min_diff
            min_diff = max_ub - ( max_x - Sigma(max_i)*eta/sqrt(n_tmp(max_i)) );
            min_diff_n_tmp = n_tmp;
            min_diff_b1 = b1;
        end
    end
    n_tmp = min_diff_n_tmp;
        
    Xbar_add = randn(k, 1) .* Sigma ./ sqrt(n_tmp - n) + Mu;
    Xbar_add(n_tmp==n) = 0;
    Xbar = (Xbar .* n + Xbar_add .* (n_tmp - n)) ./ (n_tmp);
    n = n_tmp;
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    [max_ub, max_ub_i] = max(Xbar(others) + Sigma(others)*eta./sqrt(n(others)));
    max_ub_i = others(max_ub_i);
    
    %max_ub - ( max_x - Sigma(max_i)*d/sqrt(n(max_i)) )
    
    %hold on
    %plot(Xbar)
    %plot(Xbar - Sigma*d./sqrt(n), 'g--')
    %plot(Xbar + Sigma*d./sqrt(n), 'g--')
    %hold off
    
end
    
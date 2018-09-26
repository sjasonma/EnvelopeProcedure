% Unknown Variances
% Enumerate b1

Mu;
Sigma;
k = length(Mu);
n1 = 50;
S = sqrt(chi2rnd(n1-1, k, 1) /(n1-1)) .*Sigma;

alpha;
delta;
B = 1000000;
b = 10000;
a = (1-(1-alpha)^(1/k));
eta = 6.77;

n = n1 * ones(k, 1);
Xbar = randn(k, 1) .* Sigma / sqrt(n1) + Mu;
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
[max_ub, max_ub_i] = max(Xbar(others) + S(others)*eta./sqrt(n(others)));
max_ub_i = others(max_ub_i);
n_tmp = n;

counter = 0;
while max_ub - ( max_x - S(max_i)*eta/sqrt(n(max_i)) ) > delta 
    counter = counter + 1
    counter * B;
    min_diff = inf;
    for b1 = b:b:B
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + b1;
        for ib = b:b:B-b1
            [max_ub, max_ub_i] = max(Xbar(others) + S(others)*eta./sqrt(n_tmp(others)));
            max_ub_i = others(max_ub_i);
            n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        end
        [max_ub, max_ub_i] = max(Xbar(others) + S(others)*eta./sqrt(n_tmp(others)));
        max_ub_i = others(max_ub_i);
        if max_ub - ( max_x - S(max_i)*eta/sqrt(n_tmp(max_i)) ) < min_diff
            min_diff = max_ub - ( max_x - S(max_i)*eta/sqrt(n_tmp(max_i)) );
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
    [max_ub, max_ub_i] = max(Xbar(others) + S(others)*eta./sqrt(n(others)));
    max_ub_i = others(max_ub_i);
    
    %max_ub - ( max_x - S_samp(max_i)*d/sqrt(n(max_i)) )
    
    %hold on
    %plot(Xbar)
    %plot(Xbar - S_samp*d./sqrt(n), 'g--')
    %plot(Xbar + S_samp*d./sqrt(n), 'g--')
    %hold off
    
end
    
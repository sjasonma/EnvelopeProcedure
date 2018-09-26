% Known Variances
% Compare increase of lowerbound and decrease of upperbound

Mu;
Sigma;
k = length(Mu);
n1 = 10;

alpha;
delta;
B = 100;
b = B / 10;
eta = -norminv( (1-(1-alpha)^(1/k)) / 2, 0, 1);

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
    for ib = b:b:B
        inc_lb = Sigma(max_i)*(eta/sqrt(n_tmp(max_i)) - eta/sqrt(n_tmp(max_i) + b));
        [max_ub, max_ub_i] = max(Xbar(others) + Sigma(others)*eta./sqrt(n_tmp(others)));
        max_ub_i = others(max_ub_i);
        others2 = setdiff(others, max_ub_i)';
        max2_ub = max(Xbar(others2) + Sigma(others2)*eta./sqrt(n_tmp(others2)));
        dec_ub = max_ub - max(Xbar(max_ub_i) + Sigma(max_ub_i)*eta./sqrt(n_tmp(max_ub_i) + b), max2_ub);
        if inc_lb > dec_ub
            n_tmp(max_i) = n_tmp(max_i) + b;
        else
            n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        end
    end
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
    
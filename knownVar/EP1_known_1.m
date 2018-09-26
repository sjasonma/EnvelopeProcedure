%% Envelope procedure with Known Variances
% Enumerate b1 (greedy)
% optimized based on NP_greedy_known

% Based on algo3

% Boundary 1 sqrt(n*log(n))
delta;
alpha;
B = bsize * 20;
b = bsize;
n0 = max(bsize, 2);

a = (1-(1-alpha)^(1/k));
eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma .* eta ./ sqrt(n .* log(n)); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
XUb = Xbar + d;
[max_ub, max_ub_i] = max(XUb(others));
max_ub_i = others(max_ub_i);
counter = 0;
n_maxi_inc = 0;
maxis = 0;

while max_ub - ( max_x - d(max_i) ) > delta 
    counter = counter + 1;
    n_tmp = n;
    n_tmp(max_i) = n_tmp(max_i) + B;
    d_tmp = d;
    d_tmp(max_i) = sigma(max_i) * eta ./ sqrt(n_tmp(max_i));
    XUb_tmp = XUb;
    %XUb_tmp(max_i) = Xbar(max_i) + d_tmp(max_i); %useless
    min_diff = max_ub - ( max_x - d_tmp(max_i) );
    %fprintf('%.6f\n', max_ub - ( max_x - d_tmp(max_i) ))
    min_diff_n_tmp = n_tmp;
    for b1 = (B-b):-b:0
        n_tmp(max_i) = n_tmp(max_i) - b;
        d_tmp(max_i) = sigma(max_i) * eta ./ sqrt(n_tmp(max_i) .* log(n_tmp(max_i)));
        n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        d_tmp(max_ub_i) = sigma(max_ub_i) * eta ./ sqrt(n_tmp(max_ub_i) .* log(n_tmp(max_ub_i)) );
        XUb_tmp(max_ub_i) = Xbar(max_ub_i) + d_tmp(max_ub_i);
        [max_ub, max_ub_i] = max(XUb_tmp(others));
        max_ub_i = others(max_ub_i);
        %fprintf('%.6f\n', max_ub - ( max_x - d_tmp(max_i) ))
        if max_ub - ( max_x - d_tmp(max_i) ) < min_diff
            min_diff = max_ub - ( max_x - d_tmp(max_i) );
            min_diff_n_tmp = n_tmp;
        end
    end
    n_tmp = min_diff_n_tmp;
    n_maxi_inc(counter) = n_tmp(max_i) - n(max_i);
    maxis(counter) = max_i;
    %n_tmp(max_i) - n(max_i)
        
    n_tmp - n;
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    d = sigma .* eta ./ sqrt(n .* log(n));
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
end
max_i;
sum(n);
    
function [max_i, n] = algo_EP_unknown_old(mu, sigma, delta, alpha, bsize, n0, eta)
%% Envelope procedure with Unknown Variances
% Two stages
% Enumerate b1 (greedy)
% optimized based on NP_greedy_known
B = bsize * 20;
b = bsize;
k = length(mu);
 
t = 0;
n = ones(1, k) * n0;
[W, W2] = genSamples(n0*ones(1, k), k, mu, sigma);
Xbar = W ./ n;
S = sqrt((W2 - W.^2 ./n) ./ (n-1));
d = eta * S ./ sqrt(n); % half length of confidence interval 
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
    d_tmp(max_i) = S(max_i) * eta ./ sqrt(n_tmp(max_i));
    XUb_tmp = XUb;
    %XUb_tmp(max_i) = Xbar(max_i) + d_tmp(max_i); %useless
    min_diff = max_ub - ( max_x - d_tmp(max_i) );
    %fprintf('%.6f\n', max_ub - ( max_x - d_tmp(max_i) ))
    min_diff_n_tmp = n_tmp;
    for b1 = (B-b):-b:0
        n_tmp(max_i) = n_tmp(max_i) - b;
        d_tmp(max_i) = S(max_i) * eta ./ sqrt(n_tmp(max_i));
        n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        d_tmp(max_ub_i) = S(max_ub_i) * eta ./ sqrt(n_tmp(max_ub_i));
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
     
    [W_add, W2_add] = genSamples(n_tmp - n, k, mu, sigma);
    Xbar = (Xbar .* n + W_add) ./ (n_tmp);
    n = n_tmp;
    d = S .* eta ./ sqrt(n);
    t = t + 1;
     
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
end
function [max_i, n] = algo_EPp_unknown(mu, sigma, delta, alpha, bsize, n0, eta)
%% EP+ with Unknown Variances
% Update sample variances
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
d = eta * S ./ sqrt(n .* (n-1) ./ (n-3)); % half length of confidence interval 
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
    [sort_ub, sort_ub_i] = sort(XUb(others), 'descend');
    b1 = ceil((n(max_i) + n(max_ub_i) + B) / ((S(max_i) / S(max_ub_i))^(2/3) + 1)) - n(max_i);
    b1 = min(max(b1, 0), B);
    b2 = B - b1;
    u2_after = Xbar(max_ub_i) + S(max_ub_i) * eta / sqrt(n(max_ub_i) + b2);
    if u2_after > sort_ub(2)
        % No need to consider systems other than i* and j*
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + b1;
        n_tmp(max_ub_i) = n_tmp(max_ub_i) + b2;
        min_diff_n_tmp = n_tmp;
    else
        % The identity of j* may change. Need to consider other systems.      
        n_tmp = n;
        n_tmp(max_i) = n_tmp(max_i) + B;
        d_tmp = d;
        d_tmp(max_i) = S(max_i) * eta ./ sqrt(n_tmp(max_i));
        XUb_tmp = XUb;
        %min_diff = max_ub - ( max_x - d_tmp(max_i) );
        min_diff = max_ub + d_tmp(max_i) ;
        min_diff_n_tmp = n_tmp;

        k_ub = 1;
        while k_ub < k-2
            next_ub = sort_ub(k_ub+1);
            % If there is a Xbar_i in the first k_ub candidates in sort_ub_i,
            % s.t. Xbar_i >= next_ub, then stop.
            if max(Xbar(sort_ub_i(1:k_ub))) >= next_ub
                break
            end
            n_to_add = zeros(1, k);
            si = others(sort_ub_i(1:k_ub));
            n_to_add(si) = ceil((eta .* S(si) ./ (next_ub - Xbar(si))).^2 - n_tmp(si));
            n_tmp(max_i) = n_tmp(max_i) - sum(n_to_add(si));
            if n_tmp(max_i) < n(max_i)
                break
            end
            n_tmp(si) = n_tmp(si) + n_to_add(si);
            d_tmp(max_i) = S(max_i) * eta ./ sqrt(n_tmp(max_i));
            d_tmp(si) = S(si) * eta ./ sqrt(n_tmp(si));
            XUb_tmp(si) = Xbar(si) + d_tmp(si);
            [max_ub, max_ub_i] = max(XUb_tmp(others));
            max_ub_i = others(max_ub_i);
            %if max_ub - ( max_x - d_tmp(max_i) ) < min_diff
            if max_ub + d_tmp(max_i) < min_diff
                %min_diff = max_ub - ( max_x - d_tmp(max_i) );
                min_diff = max_ub + d_tmp(max_i) ;
                min_diff_n_tmp = n_tmp;
            end
            k_ub = k_ub + 1;
            k_ub = max(k_ub, find(sort_ub < min(XUb_tmp(si)), 1));
        end
    end
    
    n_tmp = min_diff_n_tmp;
    n_maxi_inc(counter) = n_tmp(max_i) - n(max_i);
    maxis(counter) = max_i;
    %n_tmp(max_i) - n(max_i)
    
    [W_add, W2_add] = genSamples(n_tmp - n, k, mu, sigma);
    W = W + W_add;
    W2 = W2 + W2_add;
    n = n_tmp;
    Xbar = W ./ n;
    S = sqrt((W2 - W.^2 ./n) ./ (n-1));
    d = S .* eta ./ sqrt(n .* (n-1) ./ (n-3));
    t = t + 1;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
end
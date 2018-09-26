%% Envelope procedure with Known Variances
% b1
% optimized based on NP_greedy_known

% Based on algo3
delta;
alpha;
B = bsize * 100;
n0 = bsize;

a = (1-(1-alpha)^(1/k));
eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma .* eta ./ sqrt(n); % half length of confidence interval 
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
    b1 = ceil((n(max_i) + n(max_ub_i) + B) / ((sigma(max_i) / sigma(max_ub_i))^(2/3) + 1)) - n(max_i);
    b1 = min(max(b1, 0), B);
    b2 = B - b1;
    u2_after = Xbar(max_ub_i) + sigma(max_ub_i) * eta / sqrt(n(max_ub_i) + b2);
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
        d_tmp(max_i) = sigma(max_i) * eta ./ sqrt(n_tmp(max_i));
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
            n_to_add(si) = ceil((eta .* sigma(si) ./ (next_ub - Xbar(si))).^2 - n_tmp(si));
            n_tmp(max_i) = n_tmp(max_i) - sum(n_to_add(si));
            if n_tmp(max_i) < n(max_i)
                break
            end
            n_tmp(si) = n_tmp(si) + n_to_add(si);
            d_tmp(max_i) = sigma(max_i) * eta ./ sqrt(n_tmp(max_i));
            d_tmp(si) = sigma(si) * eta ./ sqrt(n_tmp(si));
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
        
    sort(n_tmp - n);
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    d = sigma .* eta ./ sqrt(n);
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
end
max_i;
sum(n);
    
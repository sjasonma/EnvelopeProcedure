%% Envelope procedure with Known Variances
% Optimize l
% Plus 2 sample
% No Waste

delta;
alpha;
B = bsize * 20;
b = bsize;
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

while max_ub - ( max_x - d(max_i) ) > delta && counter < inf
    counter = counter + 1;
    
    n_tmp = n;
    if max_ub - delta >= max_x
        n_tmp(max_ub_i) = n(max_ub_i) + bsize;
    else
        l = max_ub - delta;
        dl = sigma(max_i)^2 / (max_x - l)^3 - sigma(max_ub_i)^2 / (d(max_ub_i))^3;
        if dl > 0
            n_tmp(max_ub_i) = n(max_ub_i) + bsize;
        end
    end 
    if max(Xbar(others)) - delta > max_x - d(max_i)
        n_tmp(max_i) = n(max_i) + bsize;
    else
        l = max_x - d(max_i);
        j_cand = (eta * sigma(others) ./ (l + delta - Xbar(others))).^2 > n(others);
        j_cand = others(j_cand);
        dl = sigma(max_i)^2 / (max_x - l)^3 - sum( sigma(j_cand).^2 ./ (l + delta - Xbar(j_cand)).^3);
        if dl < 0
            n_tmp(max_i) = n(max_i) + bsize;
        end
    end
    
    n_inc = n_tmp - n;
    if test
        plot_bands;
        waitforbuttonpress;
        %plot(n(1), Xbar(1) - d(1), 'b*')
    end
    
    n_maxi_inc(counter) = n_tmp(max_i) - n(max_i);
    maxis(counter) = max_i;
    %n_tmp(max_i) - n(max_i)
    assert(sum(n_tmp >= n) == k)
        
    n_tmp - n;
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
    
%% Envelope procedure with Known Variances
% Optimize l
% Plus 2 sample

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
    
    l_l = max(max(Xbar(others)) - delta, max_x - d(max_i));
    l_r = max_x;
    l_d = (l_r - l_l) / 100;

%     hold on
    min_m = inf;
    for l = l_l: l_d: (l_r - l_d)
        m = max((eta * sigma ./ (l + delta - Xbar)).^2 - n, 0);
        m(max_i) = (eta * sigma(max_i) / (Xbar(max_i) - l))^2 - n(max_i);
        sum(m);
%         plot(l, sum(m), 'b*');
        if sum(m) > min_m
            l = l - l_d;
            break;
        end
        min_m = sum(m);
    end
    m = max((eta * sigma ./ (l + delta - Xbar)).^2 - n, 0);
    m(max_i) = max((eta * sigma(max_i) / (Xbar(max_i) - l))^2 - n(max_i), 0);
    
    
    n_tmp = n;
    if m(max_i) > 0
        n_tmp(max_i) = n(max_i) + min(ceil(m(max_i)), bsize);
%         n_tmp(max_i) = n(max_i) + bsize;
    end
    if m(max_ub_i) > 0
        n_tmp(max_ub_i) = n(max_ub_i) + min(ceil(m(max_ub_i)), bsize);
%         n_tmp(max_ub_i) = n(max_ub_i) + bsize;
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
    
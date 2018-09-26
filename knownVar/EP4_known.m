%% Envelope procedure with Known Variances
% 
% Take samples from j s.t., U_j > L_i* + delta
% m_i* = sum(m_j) (heuristic)

delta;
alpha;
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
    
    n_add = zeros(1, k);
    j_to_add = XUb > max_x - d(max_i) + delta;
    j_to_add(max_i) = 0;
    n_add(j_to_add) = bsize;
    n_add(max_i) = sum(n_add);
    n_tmp = n + n_add;
    
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
    
function eta = findEta_ub(n0, alpha, k, eta_i, N)
prob = @(eta) integral(@(y) normcdf(eta * sqrt(y / (n0-1))).^N .* chi2pdf(y, n0-1), 0, inf );

eps = 1e-2;
rhs = (1-alpha)^(1/k);
eta_l = -norminv( (1-rhs) / 2, 0, 1);
eta_u = 5 * eta_l;
eta = (eta_l + eta_u) / 2

while eta_l < eta_u * (1 - eps)
    N = 10000;
    lhs = prob(eta);
    if lhs > rhs
        eta_u = eta;
    else
        eta_l = eta;
    end
    eta = (eta_l + eta_u) / 2
end

end
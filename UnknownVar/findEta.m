function eta = findEta(n0, alpha, k, eta_i)
eps = 1e-2;
rhs = (1-alpha)^(1/k);
eta_l = -norminv( (1-rhs) / 2, 0, 1);
eta_u = 3 * eta_l;
eta = (eta_l + eta_u) / 2;

while eta_l < eta_u * (1 - eps)
    lhs = calcE_eta2(eta, eta_i, n0);
    if lhs > rhs
        eta_u = eta;
    else
        eta_l = eta;
    end
    eta = (eta_l + eta_u) / 2
end

end



function eta = solveEta(n1, alpha, k, delta, maxS)

eps = 1e-2;
rhs = (1-alpha)^(1/k);
eta_l = -norminv( (1-rhs) / 2, 0, 1);
eta_u = 2 * eta_l;
eta = (eta_l + eta_u) / 2;

while eta_l < eta_u * (1 - eps)
    N = ceil((2 * eta * maxS / delta)^2);
    lhs = calcExpct_num(eta, n1, N);
    if lhs > rhs
        eta_u = eta;
    else
        eta_l = eta;
    end
    eta = (eta_l + eta_u) / 2
end

end

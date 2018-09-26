l = u_l; r = u_u;
hold on
while l < r - 0.0001
    u = (l + r) / 2;
    nk = B - sum( (eta * sigma ./ (u - mu_o)).^2);
    lk = eta * sigma / sqrt(nk);
    if nk < 0
        l = u;
    else
        plot(nk, u+lk, 'o')
        ddu = 1 - eta * sigma / (2 * nk^(3/2)) * 2 * sum((eta*sigma)^2 ./ (u - mu_o).^3);
        if ddu > 0
            r = u;
        else
            l = u;
        end
    end
end
m_opt = [(eta * sigma ./ (u - mu_o)).^2, nk];

u + lk - Xbar(1)
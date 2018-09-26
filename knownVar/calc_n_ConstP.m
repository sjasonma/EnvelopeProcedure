function [n_1, n_others] = calc_n_ConstP(k, delta, sigma1, alpha);
%% Bisection
eta = -norminv(1 - (1 - alpha)^(1/k));
C = 2 * delta / eta / sigma1;
func_derv_m = @(m) 2 * m - 4 * (k-1) .* m ./ (m * C - 1).^3;
func_m_others = @(m) 1 ./ (C - 1./m);
lp = ceil(1/C);

if func_derv_m(lp) >= 0
    n_1 = lp^2;
    n_others = func_m_others(lp)^2;
    return
end

rp = lp * 2;
while func_derv_m(rp) <= 0
    rp = rp * 2;
end
while lp < rp - 1
    mid = ceil((lp + rp) / 2);
    if func_derv_m(mid) < 0
        lp = mid;
    else
        rp = mid;
    end
end
n_1 = lp^2;
n_others = func_m_others(lp)^2;
return



eta = 1/2 * ((2 * alpha / (k - 1)) ^ (-2 / (n1 - 1)) - 1);
h2 = 2 * eta * (n1 - 1);

bsize = 100;
S2 = chi2rnd(n1-1, k, k) /(n1-1) .* (Sigma.^2 * ones(1, k) + ones(k, 1) * Sigma'.^2);
Xbar = randn(k, 1) .* Sigma / sqrt(n1) + Mu;
if_elim = zeros(k, 1);

r = n1;
n = ones(k, 1) * r;
while 1
    W = max(0, delta / 2 / r * (h2 * S2 / delta^2 - r));
    Xbar_diff = Xbar * ones(1, k) - ones(k, 1) * Xbar';
    if_elim = ((((Xbar_diff) < -W) * (1-if_elim)) ~= 0) | if_elim;
    if sum(~if_elim) < 2
        break;
    end
    
    Xbar(~if_elim) = (Xbar(~if_elim) * r + (randn(sum(~if_elim), 1) .* Sigma(~if_elim) / sqrt(r) + Mu(~if_elim)) * bsize) / (r + bsize);
    n(~if_elim) = n(~if_elim) + bsize;
    r = r + bsize;
end
max_i = find(~if_elim);
sum(n);

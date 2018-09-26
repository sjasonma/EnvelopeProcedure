N_max = n_max;
n0 = 10;
sigma1 = sigma(1);

n = ones(1, k) * n0;
n_t = n;
Xbar = genSample(1, mu, sigma/sqrt(n0));
[max_x, max_i] = max(Xbar);

c_n_iter = 1;

while sum(n) <= N_max
    ni_r = 1./(max_x - Xbar).^2;
    others = setdiff(1:k, max_i)';
    ni_r(max_i) = sqrt(sum(ni_r(others).^2));
    ni_r = ni_r / sum(ni_r) * bsize * (sum(n_t) + 1);
    n_add = floor(max(0, ni_r - n_t));
    n_t = ni_r;
    
    X_add = genSample(1, mu .* n_add, sigma .* sqrt(n_add));
    Xbar = (Xbar .* n + X_add) ./ (n + n_add);
    n = n + n_add;
    [max_x, max_i] = max(Xbar);
    
    c_n_iter2 = floor(min(n_max, sum(n)) / unit);
    if c_n_t(c_n_iter2) == -1
        if max_i == 1
            c_n_t(c_n_iter: c_n_iter2) = 1;
        else
            c_n_t(c_n_iter: c_n_iter2) = 0;
        end
        c_n_iter = c_n_iter2 + 1;
    end
end
%% Take constant number of samples.
%% Choose the one with the highest sample mean.
%% fails: cannot provide statistical guarantee
[n_1, n_others] = calc_n_ConstP(k, delta, sigma1, alpha);
n = ones(1, k) * n_others;
n(1) = n_1;
Xbar = genSample(1, mu, sigma./sqrt(n));
[max_x, max_i] = max(Xbar);
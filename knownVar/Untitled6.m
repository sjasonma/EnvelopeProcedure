c_NP = zeros(N_iter, 1);
n_NP = zeros(N_iter, 1);
maxn_NP = zeros(N_iter, 1);
tic
for iter = 1:N_iter
    EP1_known;
    c_NP(iter) = mu(max_i) > max(mu) - delta;
    n_NP(iter) = sum(n);
    maxn_NP(iter) = max(n);
    if mod(iter, N_iter/100) == 0
     fprintf('%d : %.1f\n', iter, toc);
    end
end

fprintf('%.3f, %e +- %e\n', mean(c_NP), mean(n_NP), 1.96 * std(n_NP) / sqrt(N_iter));
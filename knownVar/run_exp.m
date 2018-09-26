mi_KN = zeros(1, N_iter);
mi_BIZ = zeros(1, N_iter);
mi_NP3 = zeros(1, N_iter);
mi_NP2 = zeros(1, N_iter);
n_KN = zeros(1, N_iter);
n_BIZ = zeros(1, N_iter);
n_NP3 = zeros(1, N_iter);
n_NP2 = zeros(1, N_iter);
tic
for iter = 1:N_iter
    KN_known;
    mi_KN(iter) = max_i;
    n_KN(iter) = sum(n);
    
    BIZ_known;
    mi_BIZ(iter) = max_i;
    n_BIZ(iter) = sum(n);
    
    NP_greedy3_known;
    mi_NP3(iter) = max_i;
    n_NP3(iter) = sum(n);
    
    fprintf('%d : %.1f\n', iter, toc);
end

fprintf('\tKN:  p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_KN) > max(mu) - delta)*100, mean(n_KN), 1.96*std(n_KN));
fprintf('\tBIZ: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_BIZ) > max(mu) - delta)*100, mean(n_BIZ), 1.96*std(n_BIZ));
fprintf('\tNP3: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP3) > max(mu) - delta)*100, mean(n_NP3), 1.96*std(n_NP3));
%fprintf('\tNP2: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP2) > max(mu) - delta)*100, mean(n_NP2), 1.96*std(n_NP2));

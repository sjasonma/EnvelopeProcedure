config_ids = 1:10;
c_KN = zeros(N_iter, length(config_ids));
c_BIZ = zeros(N_iter, length(config_ids));
c_NP3 = zeros(N_iter, length(config_ids));
n_KN = zeros(N_iter, length(config_ids));
n_BIZ = zeros(N_iter, length(config_ids));
n_NP3 = zeros(N_iter, length(config_ids));
tic
for config_id = 1:10
    for iter = 1:N_iter
        set_config2;
        set_NP_eta;
        KN_known_comVar;
        c_KN(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_KN(iter, config_id) = sum(n);

        BIZ_known_comVar;
        c_BIZ(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_BIZ(iter, config_id) = sum(n);

        NP_greedy3_known;
        c_NP3(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_NP3(iter, config_id) = sum(n);

        fprintf('%d, %d : %.1f\n', config_id, iter, toc);
    end
end
for config_id = 1:10
    fprintf('\tKN:  p = %.0f%%, n = %.2e +- %.2e\n', mean(c_KN(:, config_id)*100), mean(n_KN(:, config_id)), 1.96*std(n_KN(:, config_id)) / sqrt(N_iter));
    fprintf('\tBIZ: p = %.0f%%, n = %.2e +- %.2e\n', mean(c_BIZ(:, config_id)*100), mean(n_BIZ(:, config_id)), 1.96*std(n_BIZ(:, config_id)) / sqrt(N_iter));
    fprintf('\tNP3: p = %.0f%%, n = %.2e +- %.2e\n', mean(c_NP3(:, config_id)*100), mean(n_NP3(:, config_id)), 1.96*std(n_NP3(:, config_id)) / sqrt(N_iter));
    fprintf('\n')
end

%fprintf('\tKN:  p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_KN) > max(mu) - delta)*100, mean(n_KN), 1.96*std(n_KN));
%fprintf('\tBIZ: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_BIZ) > max(mu) - delta)*100, mean(n_BIZ), 1.96*std(n_BIZ));
%fprintf('\tNP3: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP3) > max(mu) - delta)*100, mean(n_NP3), 1.96*std(n_NP3));
%fprintf('\tNP2: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP2) > max(mu) - delta)*100, mean(n_NP2), 1.96*std(n_NP2));

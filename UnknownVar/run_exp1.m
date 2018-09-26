config_ids = 1:6;
c_KN = zeros(N_iter, length(config_ids));
c_BIZ = zeros(N_iter, length(config_ids));
c_EP = zeros(N_iter, length(config_ids));
c_EPp = zeros(N_iter, length(config_ids));
n_KN = zeros(N_iter, length(config_ids));
n_BIZ = zeros(N_iter, length(config_ids));
n_EP = zeros(N_iter, length(config_ids));
n_EPp = zeros(N_iter, length(config_ids));
tic
for iter = 1:N_iter
for config_id = config_ids
        set_config2
        
        [max_i, n] = algo_KN_unknown(mu, sigma, delta, alpha, bsize, n0);
        c_KN(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_KN(iter, config_id) = sum(n);

        [max_i, n] = algo_BIZ_unknown(mu, sigma, delta, alpha, bsize, n0);
        c_BIZ(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_BIZ(iter, config_id) = sum(n);

        [max_i, n] = algo_EP_unknown(mu, sigma, delta, alpha, bsize, n0, eta_EP);
        c_EP(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_EP(iter, config_id) = sum(n);
        
        [max_i, n] = algo_EPp_unknown(mu, sigma, delta, alpha, bsize, n0, eta_EPp);
        c_EPp(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_EPp(iter, config_id) = sum(n);

        fprintf('%d, %d : %.1f\n', config_id, iter, toc);
    end
end
for config_id = config_ids
    fprintf('\tKN:  p = %.0f%%, n = %.2e +- %.2e\n', mean(c_KN(:, config_id)*100), mean(n_KN(:, config_id)), 1.96*std(n_KN(:, config_id)) / sqrt(N_iter));
    fprintf('\tBIZ: p = %.0f%%, n = %.2e +- %.2e\n', mean(c_BIZ(:, config_id)*100), mean(n_BIZ(:, config_id)), 1.96*std(n_BIZ(:, config_id)) / sqrt(N_iter));
    fprintf('\tEP: p = %.0f%%, n = %.2e +- %.2e\n', mean(c_EP(:, config_id)*100), mean(n_EP(:, config_id)), 1.96*std(n_EP(:, config_id)) / sqrt(N_iter));
    fprintf('\tEPp: p = %.0f%%, n = %.2e +- %.2e\n', mean(c_EPp(:, config_id)*100), mean(n_EPp(:, config_id)), 1.96*std(n_EPp(:, config_id)) / sqrt(N_iter));
    fprintf('\n')
end
toc
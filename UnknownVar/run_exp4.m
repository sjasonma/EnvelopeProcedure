config_ids = [1:18]
c_u_KN = zeros(N_iter, length(config_ids));
c_u_BIZ = zeros(N_iter, length(config_ids));
c_u_EP = zeros(N_iter, length(config_ids));
c_u_EPu = zeros(N_iter, length(config_ids));

n_u_KN = zeros(N_iter, length(config_ids));
n_u_BIZ = zeros(N_iter, length(config_ids));
n_u_EP = zeros(N_iter, length(config_ids));
n_u_EPu = zeros(N_iter, length(config_ids));
tic
for config_id = [1:6, 10:18]
    for iter = 1:N_iter
        set_config4;
        
%         [max_i, n] = algo_KN_unknown_largeMemory(mu, sigma, delta, alpha, bsize, n0);
%         c_u_KN(iter, config_id) = mu(max_i) > max(mu) - delta;
%         n_u_KN(iter, config_id) = sum(n);
% 
%         [max_i, n] = algo_BIZ_unknown(mu, sigma, delta, alpha, bsize, n0);
%         c_u_BIZ(iter, config_id) = mu(max_i) > max(mu) - delta;
%         n_u_BIZ(iter, config_id) = sum(n);
% 
        [max_i, n] = algo_EP_unknown_old(mu, sigma, delta, alpha, bsize, n0, eta_EP);
        c_u_EP(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_u_EP(iter, config_id) = sum(n);
        
        [max_i, n] = algo_EPp_unknown_old(mu, sigma, delta, alpha, bsize, n0, eta_EPp);
        c_u_EPu(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_u_EPu(iter, config_id) = sum(n);

        fprintf('%d, %d : %.1f\n', config_id, iter, toc);
    end
    fprintf('%.3f, %.3f, %.3f, %.3f\n', mean(c_u_KN(:, config_id)), mean(c_u_BIZ(:, config_id)), mean(c_u_EP(:, config_id)), mean(c_u_EPu(:, config_id)))
    fprintf('%e, %e, %e, %e\n', mean(n_u_KN(:, config_id)), mean(n_u_BIZ(:, config_id)), mean(n_u_EP(:, config_id)), mean(n_u_EPu(:, config_id)))
    fprintf('%e, %e, %e, %e\n', 1.96*std(n_u_KN(:, config_id))/sqrt(N_iter), 1.96*std(n_u_BIZ(:, config_id))/sqrt(N_iter), 1.96*std(n_u_EP(:, config_id))/sqrt(N_iter), 1.96*std(n_u_EPu(:, config_id))/sqrt(N_iter))
    fprintf('\n')
end
running_time = toc
for config_id = config_ids
    config_id
    fprintf('%.3f, %.3f, %.3f, %.3f\n', mean(c_u_KN(:, config_id)), mean(c_u_BIZ(:, config_id)), mean(c_u_EP(:, config_id)), mean(c_u_EPu(:, config_id)))
    fprintf('%e, %e, %e, %e\n', mean(n_u_KN(:, config_id)), mean(n_u_BIZ(:, config_id)), mean(n_u_EP(:, config_id)), mean(n_u_EPu(:, config_id)))
    fprintf('%e, %e, %e, %e\n', 1.96/sqrt(5)*std(n_u_KN(:, config_id))/sqrt(N_iter), 1.96/sqrt(5)*std(n_u_BIZ(:, config_id))/sqrt(N_iter), 1.96/sqrt(5)*std(n_u_EP(:, config_id))/sqrt(N_iter), 1.96/sqrt(5)*std(n_u_EPu(:, config_id))/sqrt(N_iter))
    fprintf('\n')
end

%fprintf('\tKN:  p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_KN) > max(mu) - delta)*100, mean(n_KN), 1.96*std(n_KN));
%fprintf('\tBIZ: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_BIZ) > max(mu) - delta)*100, mean(n_BIZ), 1.96*std(n_BIZ));
%fprintf('\tNP3: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP3) > max(mu) - delta)*100, mean(n_NP3), 1.96*std(n_NP3));
%fprintf('\tNP2: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP2) > max(mu) - delta)*100, mean(n_NP2), 1.96*std(n_NP2));

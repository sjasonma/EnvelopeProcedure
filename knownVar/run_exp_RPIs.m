% config_ids = [1:18]
% c_KN = zeros(N_iter, length(config_ids));
% n_KN = zeros(N_iter, length(config_ids));
% c_BIZ = zeros(N_iter, length(config_ids));
% n_BIZ = zeros(N_iter, length(config_ids));
c_EP1 = zeros(N_iter, length(config_ids));
n_EP1 = zeros(N_iter, length(config_ids));
% c_EP3 = zeros(N_iter, length(config_ids));
% n_EP3 = zeros(N_iter, length(config_ids));

tic
for config_id = [1:6, 10:18]
    for iter = 1:N_iter
        set_config4;
        KN_known;
        c_KN(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_KN(iter, config_id) = sum(n);

        BIZ_known;
        c_BIZ(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_BIZ(iter, config_id) = sum(n);

        EP1_known;
        c_EP1(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_EP1(iter, config_id) = sum(n);
        
        EP3_known;
        c_EP3(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_EP3(iter, config_id) = sum(n);

        fprintf('%d, %d : %.1f\n', config_id, iter, toc);
    end
    fprintf('%.3f, %.3f, %.3f, %.3f\n', mean(c_KN(:, config_id)), mean(c_BIZ(:, config_id)), mean(c_EP1(:, config_id)), mean(c_EP3(:, config_id)))
    fprintf('%e, %e, %e, %e\n', mean(n_KN(:, config_id)), mean(n_BIZ(:, config_id)), mean(n_EP1(:, config_id)), mean(n_EP3(:, config_id)))
    fprintf('%e, %e, %e, %e\n', 1.96*std(n_KN(:, config_id))/sqrt(N_iter), 1.96*std(n_BIZ(:, config_id))/sqrt(N_iter), 1.96*std(n_EP1(:, config_id))/sqrt(N_iter), 1.96*std(n_EP3(:, config_id))/sqrt(N_iter))
    fprintf('\n')
end
for config_id = config_ids
    config_id
    fprintf('%.3f, %.3f, %.3f, %.3f\n', mean(c_KN(:, config_id)), mean(c_BIZ(:, config_id)), mean(c_EP1(:, config_id)), mean(c_EP3(:, config_id)))
    fprintf('%e, %e, %e, %e\n', mean(n_KN(:, config_id)), mean(n_BIZ(:, config_id)), mean(n_EP1(:, config_id)), mean(n_EP3(:, config_id)))
    fprintf('%e, %e, %e, %e\n', 1.96*std(n_KN(:, config_id))/sqrt(N_iter), 1.96*std(n_BIZ(:, config_id))/sqrt(N_iter), 1.96*std(n_EP1(:, config_id))/sqrt(N_iter), 1.96*std(n_EP3(:, config_id))/sqrt(N_iter))
    fprintf('\n')
end

%fprintf('\tKN:  p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_KN) > max(mu) - delta)*100, mean(n_KN), 1.96*std(n_KN));
%fprintf('\tBIZ: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_BIZ) > max(mu) - delta)*100, mean(n_BIZ), 1.96*std(n_BIZ));
%fprintf('\tNP3: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP3) > max(mu) - delta)*100, mean(n_NP3), 1.96*std(n_NP3));
%fprintf('\tNP2: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP2) > max(mu) - delta)*100, mean(n_NP2), 1.96*std(n_NP2));

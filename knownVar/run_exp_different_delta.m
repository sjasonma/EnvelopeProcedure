deltas = [1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
c_KN = zeros(N_iter, length(config_ids));
c_BIZ = zeros(N_iter, length(config_ids));
c_NP = zeros(N_iter, length(config_ids));
n_KN = zeros(N_iter, length(config_ids));
n_BIZ = zeros(N_iter, length(config_ids));
n_NP = zeros(N_iter, length(config_ids));
tic
for delta_id = 1:length(deltas)
    delta = deltas(delta_id);
    for iter = 1:N_iter
        set_config4;
        KN_known;
        c_KN(iter, delta_id) = mu(max_i) > max(mu) - delta;
        n_KN(iter, delta_id) = sum(n);

        BIZ_known;
        c_BIZ(iter, delta_id) = mu(max_i) > max(mu) - delta;
        n_BIZ(iter, delta_id) = sum(n);

        EP1_known;
        c_NP(iter, delta_id) = mu(max_i) > max(mu) - delta;
        n_NP(iter, delta_id) = sum(n);

        fprintf('%d, %d : %.1f\n', delta_id, iter, toc);
    end
end
for delta_id = 1:length(deltas)
    delta_id
    fprintf('%.3f, %.3f, %.3f\n', mean(c_KN(:, delta_id)), mean(c_BIZ(:, delta_id)), mean(c_NP(:, delta_id)))
    fprintf('%e, %e, %e\n', mean(n_KN(:, delta_id)), mean(n_BIZ(:, delta_id)), mean(n_NP(:, delta_id)))
    fprintf('%e, %e, %e\n', 1.96*std(n_KN(:, delta_id))/sqrt(N_iter), 1.96*std(n_BIZ(:, delta_id))/sqrt(N_iter), 1.96*std(n_NP(:, delta_id))/sqrt(N_iter))
    %fprintf('%f, %f\n', mean(n_KN(:, config_id) ./ n_NP(:, config_id)), mean(n_BIZ(:, config_id) ./ n_NP(:, config_id)))
    %fprintf('%f, %f\n', std(n_KN(:, config_id) ./ n_NP(:, config_id))*1.96/sqrt(N_iter), std(n_BIZ(:, config_id) ./ n_NP(:, config_id))*1.96/sqrt(N_iter))
    fprintf('%f, %f\n', mean(n_NP(:, delta_id) ./ n_KN(:, delta_id)), mean(n_NP(:, delta_id) ./ n_BIZ(:, delta_id)))
    fprintf('%f, %f\n', std(n_NP(:, delta_id) ./ n_KN(:, delta_id))*1.96/sqrt(N_iter), std(n_NP(:, delta_id) ./ n_BIZ(:, delta_id))*1.96/sqrt(N_iter))
    fprintf('\n')
end

%fprintf('\tKN:  p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_KN) > max(mu) - delta)*100, mean(n_KN), 1.96*std(n_KN));
%fprintf('\tBIZ: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_BIZ) > max(mu) - delta)*100, mean(n_BIZ), 1.96*std(n_BIZ));
%fprintf('\tNP3: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP3) > max(mu) - delta)*100, mean(n_NP3), 1.96*std(n_NP3));
%fprintf('\tNP2: p = %.2f%%, n = %.2e +- %.2e\n', mean(mu(mi_NP2) > max(mu) - delta)*100, mean(n_NP2), 1.96*std(n_NP2));

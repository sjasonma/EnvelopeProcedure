% config_ids = [1:18]
config_ids = 1;
c_EP1 = zeros(N_iter, length(config_ids));
n_EP1 = zeros(N_iter, length(config_ids));

tic
for config_id = config_ids
    for iter = 1:N_iter
%         set_config4;
%         set_NP_eta_practical;

        EP1_known_3;
        c_EP1(iter, config_id) = mu(max_i) > max(mu) - delta;
        n_EP1(iter, config_id) = sum(n);
        %fprintf('%d, %d : %.1f\n', config_id, iter, toc);
    end
    fprintf('%.3f, %.4e +- %.3e\n', mean(c_EP1(:, config_id)), mean(n_EP1(:, config_id)), 1.96*std(n_EP1(:, config_id))/sqrt(N_iter));
end
% for config_id = config_ids
%     config_id
%     fprintf('%.3f, %.4e +- %.3e\n', mean(c_EP1(:, config_id)), mean(n_EP1(:, config_id)), 1.96*std(n_EP1(:, config_id))/sqrt(N_iter));
% end

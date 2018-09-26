c_KN_t = zeros(1, N_iter);
n_KN_t = zeros(1, N_iter);
c_BIZ_t = zeros(1, N_iter);
n_BIZ_t = zeros(1, N_iter);
c_NP_t = zeros(1, N_iter);
n_NP_t = zeros(1, N_iter);

% k = 1000;
set_NP_eta;
tic
for iter = 1:N_iter
%    mu = 0:-10*delta:-10*delta*(k-1);
%    mu = randn(1, k) * 2 * delta;
%     sigma = 2 * ones(1,k);
%    sigma = sqrt(chi2rnd(4, [size(mu)]));
%     set_config4;
        
%     KN_known;
% %     c_KN_t(iter) = mu(max_i) > max(mu) - delta;
%     c_KN_t(iter) = (max_i == 1);
%     n_KN_t(iter) = sum(n);
% 
    BIZ_known;
    c_BIZ_t(iter) = mu(max_i) > max(mu) - delta;
    n_BIZ_t(iter) = sum(n);

%     EP1_known;
%     c_NP_t(iter) = mu(max_i) > max(mu) - delta;
%     n_NP_t(iter) = sum(n);
% 
     fprintf('%d : %.1f\n', iter, toc);
end
toc
% fprintf('%.3f, %.2e\n', mean(c_KN_t), mean(n_KN_t))
fprintf('%.3f, %.3f, %.3f\n', mean(c_KN_t), mean(c_BIZ_t), mean(c_NP_t))
fprintf('%.2e, %.2e, %.2e\n', mean(n_KN_t), mean(n_BIZ_t), mean(n_NP_t))
fprintf('%.2e, %.2e, %.2e\n', mean(n_KN_t)/k, mean(n_BIZ_t)/k, mean(n_NP_t)/k)
fprintf('%.2f, %.2f\n', mean(n_NP_t ./ n_KN_t), mean(n_NP_t ./ n_BIZ_t))
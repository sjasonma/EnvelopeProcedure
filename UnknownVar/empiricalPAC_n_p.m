N_iter = 10000;

tic
%% BIZ
alphas_BIZ = [0.2:-0.02:0.06, 0.05:-0.01:0.01, 0.007, 0.005, 0.003, 0.002, 0.001];
%alphas_BIZ = [0.68:-0.01:0.5, 0.45:-0.05:0.05];
%alphas_BIZ = [0.7:-0.02:0.5, 0.45:-0.05:0.05, 0.04:-0.005:0.005, 0.004:-0.001:0.001];
% alphas_BIZ = linspace(0.2, 0.005, 21);
p_BIZ_alphas = zeros(1, length(alphas_BIZ));
n_BIZ_alphas = zeros(1, length(alphas_BIZ));

c_BIZ_t = zeros(1, N_iter);
n_BIZ_t = zeros(1, N_iter);

for i_alpha = 1:length(alphas_BIZ)
    alpha = alphas_BIZ(i_alpha)
    for iter = 1:N_iter
%         set_config2;
        [max_i, n] = algo_BIZ_unknown(mu, sigma, delta, alpha, bsize, n0);
        c_BIZ_t(iter) = (mu(max_i) > mu(1) - delta);
        n_BIZ_t(iter) = sum(n);
    end
    p_BIZ_alphas(i_alpha) = mean(c_BIZ_t);
    n_BIZ_alphas(i_alpha) = mean(n_BIZ_t);
    toc
end

%% KN
alphas_KN = [0.8, 0.6:-0.1:0.3, 0.25, 0.2:-0.04:0.08, 0.05, 0.03, 0.02, 0.01:-0.002:0.004, 0.003:-0.001:0.001];
%KN_etas = [0.02:0.002:0.04, 0.045:0.005:0.08, 0.09:0.01:0.18];
%KN_etas = [0.05:0.005:0.08, 0.09:0.01:0.3, 0.32:0.02:0.42, 0.45, 0.48];
% alphas_KN = linspace(0.2, 0.005, 21);
p_KN_alphas = zeros(1, length(alphas_KN));
n_KN_alphas = zeros(1, length(alphas_KN));

c_KN_t = zeros(1, N_iter);
n_KN_t = zeros(1, N_iter);

% tic
for i_alpha = 1:length(alphas_KN)
    alpha = alphas_KN(i_alpha)
    %eta = KN_etas(i_eta)
    for iter = 1:N_iter
%         set_config2;
        [max_i, n] = algo_KN_unknown_largeMemory(mu, sigma, delta, alpha, bsize, n0);
        c_KN_t(iter) = (mu(max_i) > mu(1) - delta);
        n_KN_t(iter) = sum(n);
    end
    p_KN_alphas(i_alpha) = mean(c_KN_t);
    n_KN_alphas(i_alpha) = mean(n_KN_t);
    toc
end

%% EP
EP_etas = [2.1:0.04:2.4, 2.45:0.05:3, 3.1:0.1:3.5, 3.6:0.2:5];
%EP_etas = [1.2:0.05:2, 2.1:0.1:3, 3.2:0.2:4, 4.3, 4.6, 5];

% EP_etas = linspace(6, 8, 21);
% for i_eta = 1:length(EP_etas)
%     eta = EP_etas(i_eta);
%     EP_alphas(i_eta) = 1 - calcE_eta2(eta, eta_i_1, n0)^k;
% end

p_EP_etas = zeros(1, length(EP_etas));
n_EP_etas = zeros(1, length(EP_etas));

c_EP_t = zeros(1, N_iter);
n_EP_t = zeros(1, N_iter);

% tic
for i_eta = 1:length(EP_etas)
    eta = EP_etas(i_eta)
    for iter = 1:N_iter
%         set_config2;
        [max_i, n] = algo_EP_unknown_old(mu, sigma, delta, alpha, bsize, n0, eta);
        c_EP_t(iter) = (mu(max_i) > mu(1) - delta);
        n_EP_t(iter) = sum(n);
    end
    p_EP_etas(i_eta) = mean(c_EP_t);
    n_EP_etas(i_eta) = mean(n_EP_t);
    toc
end

%% EPp
EPp_etas = [2.1:0.04:2.4, 2.45:0.05:3, 3.1:0.1:3.5, 3.6:0.2:5];
%EPp_etas = [1.2:0.05:2, 2.1:0.1:3, 3.2:0.2:4, 4.3, 4.6, 5];
% EPp_etas = linspace(4.6, 5.9, 21);

% for i_eta = 1:length(EPp_etas)
%     eta = EPp_etas(i_eta);
%     EPp_alphas(i_eta) = 1 - (find(eta_i_2 > eta, 1) / length(eta_i_2))^k;
% end

p_EPp_etas = zeros(1, length(EPp_etas));
n_EPp_etas = zeros(1, length(EPp_etas));

c_EPp_t = zeros(1, N_iter);
n_EPp_t = zeros(1, N_iter);

% tic
for i_eta = 1:length(EPp_etas)
    eta = EPp_etas(i_eta)
    for iter = 1:N_iter
%         set_config2;
        [max_i, n] = algo_EPp_unknown_old(mu, sigma, delta, alpha, bsize, n0, eta);
        c_EPp_t(iter) = (mu(max_i) > mu(1) - delta);
        n_EPp_t(iter) = sum(n);
    end
    p_EPp_etas(i_eta) = mean(c_EPp_t);
    n_EPp_etas(i_eta) = mean(n_EPp_t);
    toc
end

%%

save(strcat('theoriticalPAC_RPI_', date), 'alphas_KN', 'alphas_BIZ', 'EP_etas', 'EPp_etas', ...
    'n_KN_alphas', 'p_KN_alphas', 'n_BIZ_alphas', 'p_BIZ_alphas', ...
    'n_EP_etas', 'p_EP_etas', 'n_EPp_etas', 'p_EPp_etas')

figure 
hold on
plot(n_KN_alphas, p_KN_alphas, 'g')
plot(n_BIZ_alphas, p_BIZ_alphas, 'b')

plot(n_EP_etas, p_EP_etas, 'r')
plot(n_EPp_etas, p_EPp_etas, 'm')
% plot(n_BIZ_alphas, 1 - alphas_BIZ, 'r')
% plot(n_KN_alphas, 1 - alphas_KN, 'g')
% plot(n_EP_etas, 1 - EP_alphas, 'b')
% plot(n_EPp_etas, 1 - EPp_alphas, 'c')
% plot(sort(n_BIZ_alphas), 1 - alphas_BIZ, 'r')
% plot(sort(n_KN_alphas), 1 - alphas_KN, 'g')
% plot(sort(n_EP_etas), 1 - EP_alphas, 'b')
% plot(sort(n_EPp_etas), 1 - EPp_alphas, 'c')

legend('KN', 'BIZ', 'UEP', 'UEPu', 'Location', 'SouthEast')
xlabel('n')
ylabel('PAC')

plot([0, 7e5], [0.95, 0.95], 'k-.')
plot([2e5, 2e5], [0.75, 1], 'k-.')

% i = find(1 - alphas_BIZ > 0.95, 1) - 1;
% n_plot = n_BIZ_alphas(i) + (n_BIZ_alphas(i+1) - n_BIZ_alphas(i)) * (0.05 - alphas_BIZ(i)) / (alphas_BIZ(i+1) - alphas_BIZ(i))

i = find(p_KN_alphas > 0.95, 1) - 1;
n_plot = n_KN_alphas(i) + (n_KN_alphas(i+1) - n_KN_alphas(i)) * (0.95 - p_KN_alphas(i)) / (p_KN_alphas(i+1) - p_KN_alphas(i))
plot([n_plot, n_plot], [0.75, 0.95], 'g--')

i = find(p_BIZ_alphas > 0.95, 1) - 1;
n_plot = n_BIZ_alphas(i) + (n_BIZ_alphas(i+1) - n_BIZ_alphas(i)) * (0.95 - p_BIZ_alphas(i)) / (p_BIZ_alphas(i+1) - p_BIZ_alphas(i))
plot([n_plot, n_plot], [0.75, 0.95], 'b--')

i = find(p_EP_etas > 0.95, 1) - 1;
n_plot = n_EP_etas(i) + (n_EP_etas(i+1) - n_EP_etas(i)) * (0.95 - p_EP_etas(i)) / (p_EP_etas(i+1) - p_EP_etas(i))
plot([n_plot, n_plot], [0.75, 0.95], 'r--')

i = find(p_EPp_etas > 0.95, 1) - 1;
n_plot = n_EPp_etas(i) + (n_EPp_etas(i+1) - n_EPp_etas(i)) * (0.95 - p_EPp_etas(i)) / (p_EPp_etas(i+1) - p_EPp_etas(i))
plot([n_plot, n_plot], [0.75, 0.95], 'm--')


i = find(n_KN_alphas > 2e5, 1) - 1;
p_plot = p_KN_alphas(i) + (p_KN_alphas(i+1) - p_KN_alphas(i)) * (2e5 - n_KN_alphas(i)) / (n_KN_alphas(i+1) - n_KN_alphas(i))
plot([0, 2e5], [p_plot, p_plot], 'g--')

i = find(n_BIZ_alphas > 2e5, 1) - 1;
p_plot = p_BIZ_alphas(i) + (p_BIZ_alphas(i+1) - p_BIZ_alphas(i)) * (2e5 - n_BIZ_alphas(i)) / (n_BIZ_alphas(i+1) - n_BIZ_alphas(i))
plot([0, 2e5], [p_plot, p_plot], 'b--')

i = find(n_EP_etas > 2e5, 1) - 1;
p_plot = p_EP_etas(i) + (p_EP_etas(i+1) - p_EP_etas(i)) * (2e5 - n_EP_etas(i)) / (n_EP_etas(i+1) - n_EP_etas(i))
plot([0, 2e5], [p_plot, p_plot], 'r--')

i = find(n_EPp_etas > 2e5, 1) - 1;
p_plot = p_EPp_etas(i) + (p_EPp_etas(i+1) - p_EPp_etas(i)) * (2e5 - n_EPp_etas(i)) / (n_EPp_etas(i+1) - n_EPp_etas(i))
plot([0, 2e5], [p_plot, p_plot], 'm--')


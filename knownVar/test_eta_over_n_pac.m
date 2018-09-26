N_iter = 10000;
tic
%%
% (v1) N_iter = 5000;
% (v1) alphas_BIZ = [0.2:-0.01:0.01,0.009:-0.001:0.001];
%N_iter = 10;
% idx = [1 3 5 7 9 11 13 15 16 17 18 19 20 23 25 27 28 29];
alphas_BIZ = [0.2:-0.02:0.06, 0.05:-0.01:0.01, 0.07, 0.05, 0.03, 0.02, 0.01];
alphas_BIZ = [0.2:-0.02:0.06, 0.05:-0.01:0.01, 0.007, 0.005, 0.003, 0.002, 0.001];
p_BIZ_alphas = zeros(1, length(alphas_BIZ));
n_BIZ_alphas = zeros(1, length(alphas_BIZ));

c_BIZ_t = zeros(1, N_iter);
n_BIZ_t = zeros(1, N_iter);

% tic
for i_alpha = 1:length(alphas_BIZ)
    alpha = alphas_BIZ(i_alpha)
    for iter = 1:N_iter
        BIZ_known;
        c_BIZ_t(iter) = (max_i == 1);
        n_BIZ_t(iter) = sum(n);
    end
    p_BIZ_alphas(i_alpha) = mean(c_BIZ_t);
    n_BIZ_alphas(i_alpha) = mean(n_BIZ_t);
    toc
end

%%
% (v1) N_iter = 2000;
% (v1) alphas_KN = [0.5:-0.05:0.2, 0.18:-0.02:0.06, 0.05:-0.01:0.01, 0.009:-0.001:0.001];
%N_iter = 10000;
% idx = [1 3 5 6 7 9 11 13 15 17 18 19 21 23 25 26 27 28];
alphas_KN = [0.8, 0.6:-0.1:0.3, 0.25, 0.2:-0.04:0.08, 0.05, 0.03, 0.02, 0.01:-0.002:0.004, 0.003:-0.001:0.001];
p_KN_alphas = zeros(1, length(alphas_KN));
n_KN_alphas = zeros(1, length(alphas_KN));

c_KN_t = zeros(1, N_iter);
n_KN_t = zeros(1, N_iter);

% tic
for i_alpha = 1:length(alphas_KN)
    alpha = alphas_KN(i_alpha)
    for iter = 1:N_iter
        KN_known;
        c_KN_t(iter) = (max_i == 1);
        n_KN_t(iter) = sum(n);
    end
    p_KN_alphas(i_alpha) = mean(c_KN_t);
    n_KN_alphas(i_alpha) = mean(n_KN_t);
    toc
end

%%
% (v1) N_iter = 2000;
% (v2) NP_etas = [2.2:0.02:2.8, 2.85:0.03:3, 3.1:0.1:3.8, 4:0.2:4.6];
%N_iter = 10000;
% idx = [2:2:10, 13:3:31, 32:3:38, 39:2:45, 46:1:49];
NP_etas = [2.22:0.04:2.38, 2.44:0.06:2.8, 2.85,2.94,3.1, 3.2:0.2:4.6];
p_NP_etas = zeros(1, length(NP_etas));
n_NP_etas = zeros(1, length(NP_etas));

c_NP_t = zeros(1, N_iter);
n_NP_t = zeros(1, N_iter);

% tic
for i_eta = 1:length(NP_etas)
    NP_eta = NP_etas(i_eta)
    for iter = 1:N_iter
        EP3_known;
        c_NP_t(iter) = (max_i == 1);
        n_NP_t(iter) = sum(n);
    end
    p_NP_etas(i_eta) = mean(c_NP_t);
    n_NP_etas(i_eta) = mean(n_NP_t);
    toc
end

%%
figure 
hold on
plot(n_KN_alphas, p_KN_alphas, 'g')
plot(n_BIZ_alphas, p_BIZ_alphas, 'b')
plot(n_NP_etas, p_NP_etas, 'r')
% plot(n_KN_alphas, p_KN_alphas, 'go')
% plot(n_BIZ_alphas, p_BIZ_alphas, 'bo')
% plot(n_NP_etas, p_NP_etas, 'ro')

% plot([1e5, 6e5], [0.95, 0.95], 'k-.')
% plot([3.06e5, 3.06e5], [0.75, 0.95], 'g--')
% plot([2.19e5, 2.19e5], [0.75, 0.95], 'b--')
% plot([1.50e5, 1.50e5], [0.75, 0.95], 'r--')
% 
% plot([2e5, 2e5], [0.75, 1], 'k-.')
% plot([1e5, 2e5], [0.827, 0.827],  'g--')
% plot([1e5, 2e5], [0.935, 0.935],  'b--')
% plot([1e5, 2e5], [0.987, 0.987],  'r--')

legend('KN', 'BIZ', 'EP')
xlabel('n')
ylabel('PAC')

%%
% p_BIZ_alphas2 = p_BIZ_alphas;
% n_BIZ_alphas2 = n_BIZ_alphas;
% p_BIZ_alphas = p_BIZ_alphas * 0.5 + p_BIZ_alphas2 * 0.5;
% n_BIZ_alphas = n_BIZ_alphas * 0.5 + n_BIZ_alphas2 * 0.5;
% 
% p_KN_alphas2 = p_KN_alphas;
% n_KN_alphas2 = n_KN_alphas;
% p_KN_alphas = p_KN_alphas * 0.5 + p_KN_alphas2 * 0.5;
% n_KN_alphas = n_KN_alphas * 0.5 + n_KN_alphas2 * 0.5;
% 
% p_NP_etas2 = p_NP_etas;
% n_NP_etas2 = n_NP_etas;
% p_NP_etas = p_NP_etas * 0.5 + p_NP_etas2 * 0.5;
% n_NP_etas = n_NP_etas * 0.5 + n_NP_etas2 * 0.5;
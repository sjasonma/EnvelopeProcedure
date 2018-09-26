a = (1-(1-alpha)^(1/k));
eta_i = [];
maxn_i = [];
m = 5000;
M = 2e7;
N = 10000;
bdry = ones(m, 1) * sqrt(1:N);
tic
while length(eta_i) < M
    length(eta_i)
    W = cumsum(randn(m, N)')';
    [eta_t, maxn_t] = max((W./bdry)');
    eta_i = [eta_i;eta_t'];
    maxn_i = [maxn_i; maxn_t'];
    toc
end
[eta_i, eta_i_order] = sort(eta_i);
maxn_i = maxn_i(eta_i_order);
fprintf('eta(%d) = %.2f\n', ceil(length(eta_i)*1*(1-a)), eta_i(ceil(length(eta_i)*1*(1-a))))
%eta = eta_i(ceil(length(eta_i)*1*(1-a)))

%(2*eta*1/delta)^2

%W_it = W(max((W./bdry)')' > eta,:);

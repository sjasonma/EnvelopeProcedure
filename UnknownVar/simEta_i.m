 % For stochastic process n bar(x(n)) / S(n).
a = (1-(1-alpha)^(1/k));
eta_i = [];
maxn_i = [];
m = 10000;
M = 2e7;
N = 1000;
%n0 = 50;
ni = repmat((n0:N)', [1, m]);
bdry = sqrt(ni.*(ni-1)./(ni-3));
tic
while length(eta_i) < M
    %length(eta_i) / M
    X = randn(N, m);
    W = cumsum(X);
    W = W(n0:N, :);
    Xsq = cumsum(X.^2);
    Xsq = Xsq(n0:N, :);
    S = sqrt(Xsq./ (ni-1) - W.^2 ./ ni ./ (ni-1));
    [eta_t, maxn_t] = max(W./S./bdry);
    eta_i = [eta_i, eta_t];
    maxn_i = [maxn_i, maxn_t];
    %toc
end
[eta_i, eta_i_order] = sort(eta_i);
maxn_i = maxn_i(eta_i_order);
k = 100;
a = (1-(1-alpha)^(1/k));
fprintf('eta(%d) = %.2f\n', ceil(length(eta_i)*1*(1-a)), eta_i(ceil(length(eta_i)*1*(1-a))));
k = 1000;
a = (1-(1-alpha)^(1/k));
fprintf('eta(%d) = %.2f\n', ceil(length(eta_i)*1*(1-a)), eta_i(ceil(length(eta_i)*1*(1-a))));
k = 10000;
a = (1-(1-alpha)^(1/k));
fprintf('eta(%d) = %.2f\n', ceil(length(eta_i)*1*(1-a)), eta_i(ceil(length(eta_i)*1*(1-a))));
%eta = eta_i(ceil(length(eta_i)*1*(1-a)))

%(2*eta*1/delta)^2

%W_it = W(max((W./bdry)')' > eta,:);

eps = 0.5;
eps = 0.01;

psi_lil = @(delta) (2+eps)/eps * (delta / log(1+eps))^(1+eps);
delta = binarySearch(psi_lil, a, 1e-4, log(1+eps)/e, 1e-7, 1)
psi_lil(delta)
(1+sqrt(eps)) * sqrt(2*(1+eps)*log(log((1+eps)*N)/delta))


psi_ep = @(eta) 2 * (log(N) / log(1+eps)) * exp(-(1+eps) * eta);
eta = binarySearch(psi_ep, a, 1, 20, 0.001, 0)
psi_ep(eta)
(1 + sqrt(eps)) * sqrt(2*(1+eps)*eta)

% Fixed point
eta = (1 + sqrt(eps)) * sqrt(2 * log( (4 * log(2 * eta * sigma * (1+eps) / delta)) / (a * log(1+eps)) ))


% For Normal, given N
eta = (1 + sqrt(eps)) * norminv(1 - a/2 * log(1+eps) / log(N*(1+eps)))
% Fixed point
eta = (1 + sqrt(eps)) * pl
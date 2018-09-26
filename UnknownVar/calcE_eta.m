% function E = calcE_eta(eta, eta_i, n0)
l = length(eta_i);
p = (1:l)' / l;
x = eta_i;
y = (n0-1) / (eta^2) * x;
dz = [0; eta_i(2:end) - eta_i(1:l-1)];
E = sum(p .* chi2pdf(y .* x, n0-1) .*  2 .* y .* dz);
end
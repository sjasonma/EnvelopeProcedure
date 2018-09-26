function E = calcE_eta2(eta, eta_i, n0)
l = length(eta_i);
x = max(eta_i, 0);
E = mean(chi2cdf((n0 - 1) * x.^2 / eta.^2, n0 - 1));
end
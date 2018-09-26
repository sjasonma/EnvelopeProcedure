function NP_eta = appr_NP_eta_k(k)
NP_eta = 3.015 + 0.711 * (log(k)/log(10)) - 0.035 * (log(k)/log(10))^2;
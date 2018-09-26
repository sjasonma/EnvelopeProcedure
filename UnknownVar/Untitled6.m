tic; [max_i, n] = algo_KN_unknown(mu, sigma, delta, alpha, bsize, n0); mu(max_i) > max(mu) - delta, sum(n), toc
tic; [max_i, n] = algo_BIZ_unknown(mu, sigma, delta, alpha, bsize, n0); mu(max_i) > max(mu) - delta, sum(n), toc
tic; [max_i, n] = algo_EP_unknown(mu, sigma, delta, alpha, bsize, n0, eta_EP); mu(max_i) > max(mu) - delta, sum(n), toc
tic; [max_i, n] = algo_EPp_unknown(mu, sigma, delta, alpha, bsize, n0, eta_EPp); mu(max_i) > max(mu) - delta, sum(n), toc
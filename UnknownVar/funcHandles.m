genSample = @(n, mu, sigma) randn(n, length(mu)) .* (ones(n, 1) * sigma) + ones(n, 1) * mu;
genVar = @(n, sigma) chi2rnd(n-1, 1, length(sigma)) .* sigma.^2 / (n-1);
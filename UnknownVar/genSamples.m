function [sumX, sumX2] = genSamples(n, k, mu, sigma)
% return sum of X and sum of X^2.
sumX = randn(1, k) .* sigma .* sqrt(n) + mu .* n;
sumX2 = sumX.^2 ./ n + chi2rnd(n-1, 1, k) .* sigma.^2;
sumX2(n==0) = 0;
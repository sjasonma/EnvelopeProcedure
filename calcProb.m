function prob = calcProb(eta, N)
fun = @(eta) calcProb1(eta, N);
prob = arrayfun(fun, eta);

function prob = calcProb1(eta, N)
c = -log(1-(1-normcdf(eta)));
f2 = @(x, n) normpdf(x) .* (1 - normcdf(sqrt(n) .* eta - sqrt(n-1) .* x));
int_g = integral2(f2, -inf, eta, 1, N) / normcdf(eta);
prob = exp(- int_g - c);
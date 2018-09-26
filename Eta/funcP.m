function p = funcP(c, m)
n = 0:m;
p = sum( (-2*c^2).^n ./ factorial(2*n) .* factorial(m) ./ factorial(m-n));
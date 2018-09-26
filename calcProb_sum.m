%% Test new method to compute P in (1)

normcdf_eta = normcdf(eta);
PEc_cond = 1 - normcdf_eta;
PEc = PEc_cond;
tic
for n = 2:N
    f_cond = @(x) normpdf(x) .* (1 - normcdf(sqrt(n) .* eta - sqrt(n-1) .* x));
    PEc_cond(n) = integral(f_cond, -inf, eta) / normcdf_eta;
    PEc(n) = PEc(n-1) + PEc_cond(n) * (1 - PEc(n-1));
end
toc
p_sum = 1 - PEc(N)


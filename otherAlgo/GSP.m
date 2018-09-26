% All-pair screening
bsize = 100;
rbar = 80;

S = sqrt(chi2rnd(n1-1, k, 1) /(n1-1)) .* Sigma;

eta = solveEta(n1, alpha/2, k);
h = solveH(k, alpha/2, n1);

A = eta * sqrt(n1 - 1);
h_delta2 = h * h / (delta * delta);

ni = zeros(k, 1);
stage = ni;

beta_hat = bsize / mean(S);
bs = ceil(beta_hat * S);
S2_n_rbar = S.^2 ./ (n1 + rbar * bs);
t_rbar = 1 ./ (S2_n_rbar * ones(1, k) + ones(k,1) * S2_n_rbar');
a = A * sqrt(t_rbar);

if_elim = zeros(k, 1);

%Stage 1, sample mean and variance = Mu and S.
ni = n1;
sum_i = n1 * Mu + randn(k, 1) .* Sigma * sqrt(n1);
%Stage 2.
for r = 1 : rbar
    S2_n_r = S.^2 ./ ni;
    t_r =  1 ./ (S2_n_r * ones(1, k) + ones(k,1) * S2_n_r');
    mean_diff = (sum_i./ni) * ones(1, k) - ones(k, 1) * (sum_i./ni)';
    %if_elim = sum((t_r .* (mean_diff) < -a)')' ~= 0;
    if_elim = (((t_r .* (mean_diff) < -a) * (1-if_elim)) ~= 0) | if_elim;
    
    bs(if_elim) = 0;
    stage(if_elim) = 2;
    if(sum(if_elim == 0) <= 1)
        break;
    end
    
    ni = ni + bs;
    sum_i = sum_i + bs .* Mu + randn(k, 1) .* Sigma .* sqrt(bs);
end
if(sum(if_elim == 0) <= 1)
    sum(n)
    return;
end
%Stage 3.
stage(~if_elim) = 3;
phase2sys = sum(stage==3);
n = ni;
n(~if_elim) = max(ni(~if_elim), ceil(h_delta2 * S(~if_elim).^2));
sum_i(~if_elim) = sum_i(~if_elim) + (n(~if_elim) - ni(~if_elim)) .* Mu(~if_elim) + randn(sum(~if_elim), 1) .* Sigma(~if_elim) .* sqrt(n(~if_elim) - ni(~if_elim));

[max_x, max_i] = max(sum_i ./ n);

sum(n)
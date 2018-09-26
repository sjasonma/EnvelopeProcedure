n = 10000;
k = 1000;
t = (1:n)';
tt = repmat(t, [1, k]);
mu = zeros(1, k);
sigma = ones(1, k);
funcHandles;
X = genSample(n, mu, sigma);
Xsq = X.^2;
Xsqs = cumsum(Xsq);
Xsqs = Xsqs(t, :);
Xsum = cumsum(X);
Xsum = Xsum(t, :);
Xvar = Xsqs./tt - Xsum.^2./(tt.^2);

plot(Xsum)
plot(Xsum ./ sqrt(tt))
plot(Xsum ./ sqrt(tt .* log(log(tt))))
plot(Xsum ./ tt)

plot(Xsum ./ Xvar ./ sqrt(tt))
plot(Xsum ./ Xvar ./ sqrt(tt .* log(log(tt))))

%%%%%%%%%%%%%%%
%k = 1000
%2-stage:
    n0 = 10; eta = 10.28;
    n0 = 20; eta = 7.30; eta_ub = 9.27;
    n0 = 50; eta = 6.29; eta_ub = 6.86;
%update-variance:
    first = 10; eta = 6.25;
    first = 20; eta = 5.17;
    first = 50; eta = 4.80;

%%%%%%%%%%%%%%
k = 1000;
delta = 0.1;
mu = randn(1, k)*2;
mu = sort(mu);
sigma = sqrt(chi2rnd(4,1,k));


%%%%%%%%%%%%%
tic
l = 10000;
count = zeros(1, l);
for i = 1:l
    W = cumsum(randn(n, k-1));
    We = W ./ tt - eta ./ sqrt(tt);
    maxWe = max(We')';
    wk = cumsum(randn(n, 1));
    wke = wk ./ t + eta ./ sqrt(t);
    count(i) = sum((maxWe >= 0) & (wke <= 0)) > 1;
    if mod(i, 100) == 0
        fprintf('%d, %f\n', i, toc);
    end
end
mean(count)

%%%%%%%%%%%%%
k = 1000;
alpha = 0.05;
n = 10000;
t = (1:n)';
tt = repmat(t, [1, k-1]);
eta_i = 1;
l = 10000;
for eta = 2.6:0.05:3
    count = zeros(1, l);
    for i = 1:l
        W = cumsum(randn(n, k-1));
        We = W ./ tt - eta ./ sqrt(tt);
        maxWe = max(We')';
        wk = cumsum(randn(n, 1));
        wke = wk ./ t + eta ./ sqrt(t);
        count(i) = sum((maxWe >= 0) & (wke <= 0)) > 1;
%         if mod(i, 100) == 0
%             fprintf('%d, %f\n', i, toc);
%         end
    end
    p_eta(eta_i) = mean(count);
    fprintf('eta = %.1f, p = %.4f\n', eta, p_eta(eta_i));
    eta_i = eta_i + 1;
end
%%%%%%%%%%%%%%%
eta_l = 2.7; eta_r = 3.2;
while eta_l < eta_r - 0.005
    eta = (eta_l + eta_r) / 2;
    count = zeros(1, l);
    for i = 1:l
        W = cumsum(randn(n, k-1));
        We = W ./ tt - eta ./ sqrt(tt);
        maxWe = max(We')';
        wk = cumsum(randn(n, 1));
        wke = wk ./ t + eta ./ sqrt(t);
        count(i) = sum((maxWe >= 0) & (wke <= 0)) > 1;
    end
    fprintf('eta = %.3f, p = %.4f\n', eta, mean(count));
    if mean(count) > alpha
        eta_l = eta;
    else
        eta_r = eta;
    end
end
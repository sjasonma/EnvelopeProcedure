eta = 5;
delta = 0.1;
N = (2*eta*1/delta)^2; % max number of steps of random walk
M = 1000; % number of samples
%mu = 0;
mu = eta  / sqrt(N);

progBar = waitbar(0,'Please wait...');
maxIter = 100;
for i = 1:maxIter
    W = cumsum(randn(M, N), 2);
    V = W + repmat(mu*(1:N), [M,1]); % + drift
    V_N = V(:, N);
    U = V ./ repmat(sqrt(1:N), [M, 1]); % / sqrt(n)
    I = max(U, [], 2) > eta;
    L = exp(N*mu^2/2 - mu*V_N);
    p(i) = mean(I.*L);
    waitbar(i / maxIter)
end
close(progBar)

mean(p), std(p)
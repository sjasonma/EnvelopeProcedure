Delta = 0.1;
switch config_id
    case 1
        mu = zeros(1, k);
        mu(1) = Delta;
        delta = Delta;
        bsize = 100;
    case 2
        mu = zeros(1, k);
        mu(1) = Delta;
        delta = Delta / 5;
        bsize = 200;
    case 3
        mu = 0:-Delta:-Delta*(k-1);
        delta = Delta;
        bsize = 10;
    case 4
        mu = 0:-Delta:-Delta*(k-1);
        delta = Delta / 5;
        bsize = 5;
    case 5
        mu = sort(randn(1, k) * 2 * Delta, 'descend');
        delta = Delta;
        bsize = 100;
    case 6
        mu = sort(randn(1, k) * 5 * Delta, 'descend');
        delta = Delta;
        bsize = 2;
    
end
% sigma = chi2rnd(4, 1, k);
sigma = 2 * ones(1, k);
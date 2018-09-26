switch config_id
    case 1
        k = 100;
        mu = zeros(1, k);
        mu(1) = delta;
        bsize = 2;
    case 2
        k = 1000;
        mu = zeros(1, k);
        mu(1) = delta;
        bsize = 5;
    case 3
        k = 10000;
        mu = zeros(1, k);
        mu(1) = delta;
        bsize = 20;
    case 4
        k = 100;
        mu = 0:-delta:-delta*(k-1);
        bsize = 1;
    case 5
        k = 1000;
        mu = 0:-delta:-delta*(k-1);
        bsize = 1;
    case 6
        k = 10000;
        mu = 0:-delta:-delta*(k-1);
        bsize = 1;
    case 7
        k = 100;
        mu = randn(1, k) * 1 * delta;
        mu = sort(mu, 'descend');
        bsize = 5;
    case 8
        k = 1000;
        mu = randn(1, k) * 1 * delta;
        mu = sort(mu, 'descend');
        bsize = 10;
    case 9
        k = 10000;
        mu = randn(1, k) * 1 * delta;
        mu = sort(mu, 'descend');
        bsize = 100;
    case 10
        k = 100;
        mu = randn(1, k) * 2 * delta;
        mu = sort(mu, 'descend');
        bsize = 1;
    case 11
        k = 1000;
        mu = randn(1, k) * 2 * delta;
        mu = sort(mu, 'descend');
        bsize = 4;
    case 12
        k = 10000;
        mu = randn(1, k) * 2 * delta;
        bsize = 20;
    case 13
        k = 100;
        mu = randn(1, k) * 5 * delta;
        bsize = 1;
    case 14
        k = 1000;
        mu = randn(1, k) * 5 * delta;
        bsize = 1;
    case 15
        k = 10000;
        mu = randn(1, k) * 5 * delta;
        bsize = 2;

    case 16
        k = 100;
        mu = randn(1, k) * 10 * delta;
        bsize = 1;
    case 17
        k = 1000;
        mu = randn(1, k) * 10 * delta;
        bsize = 1;
    case 18
        k = 10000;
        mu = randn(1, k) * 10 * delta;
        bsize = 2;
end
mu = sort(mu, 'descend');
set_NP_eta;
%set_NP_eta_practical;
sigma = sqrt(chi2rnd(4, [size(mu)]));
%sigma = 2 * ones(1,k);
Mu = mu;
Sigma = sigma;
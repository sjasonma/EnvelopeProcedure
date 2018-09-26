switch config_id
    case 1
        Delta = delta;
        mu = zeros(1, k);
        mu(1) = Delta;
    case 2
        Delta = delta / 5;
        mu = zeros(1, k);
        mu(1) = Delta;
    case 3
        Delta = delta * 5;
        mu = zeros(1, k);
        mu(1) = Delta;
    case 4
        Delta = delta;
        mu = 0:-Delta:-Delta*(k-1);
    case 5
        Delta = delta / 5;
        mu = 0:-Delta:-Delta*(k-1);
    case 6
        Delta = delta * 5;
        mu = 0:-Delta:-Delta*(k-1);
    case 7
        Delta = delta;
        mu = sort(randn(1, k) * Delta, 'descend');
    case 8
        Delta = delta;
        mu = sort(randn(1, k) * 2 * Delta, 'descend');
    case 9
        Delta = delta;
        mu = sort(randn(1, k) * 5 * Delta, 'descend');
    case 10
        Delta = delta;
        mu = sort(randn(1, k) * 10 * Delta, 'descend');
    
end
%sigma = chi2rnd(4, 1, k);
sigma = 20 * Delta * ones(1, k);

H = sum((sigma ./ max(max(mu) - mu, delta)) .^ 2);
%bsize = ceil(H / 2000);
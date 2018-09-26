alpha = 0.05;
switch config_id
    case 1
        k = 1000;
        mu = 0:-delta:-delta*(k-1);
        sigma = 2 * ones(1, k);
        %fprintf('MDM1 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 2
        k = 1000;
        mu = 0:-delta:-delta*(k-1);
        sigma = 4 * ones(1, k);
        %fprintf('MDM1 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 3
        k = 1000;
        mu = 0:-delta/5:-delta/5*(k-1);
        sigma = 2 * ones(1, k);
        %fprintf('MDM5 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 4
        k = 1000;
        mu = 0:-delta/5:-delta/5*(k-1);
        sigma = 4 * ones(1, k);
        %fprintf('MDM5 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 5
        k = 1000;
        mu = randn(1, k) * 2 * delta;
        sigma = 2 * ones(1,k);
        %fprintf('RPI2 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 6
        k = 1000;
        mu = randn(1, k) * 2 * delta;
        sigma = 4 * ones(1,k);
        %fprintf('RPI2 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 7
        k = 1000;
        mu = randn(1, k) * 5 * delta;
        sigma = 2 * ones(1,k);
        %fprintf('RPI5 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 8
        k = 1000;
        mu = randn(1, k) * 5 * delta;
        sigma = 4 * ones(1,k);
        %fprintf('RPI5 with k = %d, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 9
        k = 10000;
        mu = Mu_synth1_10000;
        sigma = 2 * ones(1,k);
        %fprintf('Synth1 with k = 10000, delta = %f, sigma = %f\n', k, delta, sigma(1));
    case 10
        k = 10000;
        mu = Mu_synth1_10000;
        sigma = 4 * ones(1,k);
        %fprintf('Synth1 with k = 10000, delta = %f, sigma = %f\n', k, delta, sigma(1));
end

Mu = mu;
Sigma = sigma;
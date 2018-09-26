sig = 2;
config_names = {'SC', 'SC-INC', 'SC-DEC', 'MDM', 'MDM-INC', 'MDM-DEC', 'RPI1', 'RPI2', 'RPI2-HET', 'RPI-HET'};
switch config_id
    case 1
%         fprintf('SC with k = %d, delta = %f\n', k, delta);
        mu = zeros(1, k);
        mu(1) = delta;
        sigma = sig * ones(1, k);
    case 2
%         fprintf('SC-INC with k = %d, delta = %f\n', k, delta);
        mu = zeros(1, k);
        mu(1) = delta;
        sigma = sig/2 + sig * (1:k) / k;
    case 3
%         fprintf('SC-DEC with k = %d, delta = %f\n', k, delta);
        mu = zeros(1, k);
        mu(1) = delta;
        sigma = sig/2 + sig * (k:-1:1) / k;
    case 4
%         fprintf('MDM with k = %d, delta = %f\n', k, delta);
        mu = 0:-delta:-delta*(k-1);
        sigma = sig * ones(1, k);
    case 5
%         fprintf('MDM-INC with k = %d, delta = %f\n', k, delta);
        mu = 0:-delta:-delta*(k-1);
        sigma = sig/2 + sig * (1:k) / k;
    case 6
%         fprintf('MDM-DEC with k = %d, delta = %f\n', k, delta);
        mu = 0:-delta:-delta*(k-1);
        sigma = sig/2 + sig * (k:-1:1) / k;
    case 7
%         fprintf('RPI2 with k = %d, delta = %f\n', k, delta);
        mu = randn(1, k) * 2 * delta;
        %[max_mu, max_i] = max(mu);
        %mu = min(max_mu - delta, mu);
        %mu(max_i) = max_mu;
        sigma = sig * ones(1,k);
    case 8
%         fprintf('RPI5 with k = %d, delta = %f\n', k, delta);
        mu = randn(1, k) * 5 * delta;
        %[max_mu, max_i] = max(mu);
        %mu = min(max_mu - delta, mu);
        %mu(max_i) = max_mu;
        sigma = sig * ones(1,k);
    case 9
%         fprintf('RPI2-HET with k = %d, delta = %f\n', k, delta);
        mu = randn(1, k) * 2 * delta;
        %[max_mu, max_i] = max(mu);
        %mu = min(max_mu - delta, mu);
        %mu(max_i) = max_mu;
        sigma = sig/2 + sig * (1:k) / k;
    case 10
%         fprintf('RPI5-HET with k = %d, delta = %f\n', k, delta);
        mu = randn(1, k) * 5 * delta;
        %[max_mu, max_i] = max(mu);
        %mu = min(max_mu - delta, mu);
        %mu(max_i) = max_mu;
        sigma = sig/2 + sig * (1:k) / k;
end
mu = sort(mu);
Mu = mu;
Sigma = sigma;
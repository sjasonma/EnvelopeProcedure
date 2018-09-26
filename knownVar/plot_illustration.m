%% plot illustration of the EP
k = 3;
delta = 0.1;
mu = [0.15, 0, -0.15];
sigma1 = 3;
sigma = sigma1 * ones(1, k);
eta = 3.3;



%% New procedure with Known Variances
% Enumerate b1 (greedy)
% optimized based on NP_greedy_known

% Based on algo4

rng(27)

delta;
alpha;
bsize = 1;
B = bsize * 10;
b = bsize;
n0 = bsize*100;

a = (1-(1-alpha)^(1/k));
eta = NP_eta;
sigma1 = sigma(1);

t = n0;
n = ones(1, k) * n0;
Xbar = genSample(1, mu, sigma/sqrt(n0));
d = sigma1 * eta ./ sqrt(n); % half length of confidence interval 
[max_x, max_i] = max(Xbar);
others = setdiff(1:k, max_i)';
XUb = Xbar + d;
[max_ub, max_ub_i] = max(XUb(others));
max_ub_i = others(max_ub_i);
counter = 1;
n_maxi_inc = 0;
maxis = 0;

Xbar_hist = Xbar;
n_hist = n;

while max_ub - ( max_x - d(max_i) ) > delta 
    counter = counter + 1;
    n_tmp = n;
    n_tmp(max_i) = n_tmp(max_i) + B;
    d_tmp = d;
    d_tmp(max_i) = sigma1 * eta ./ sqrt(n_tmp(max_i));
    XUb_tmp = XUb;
    %XUb_tmp(max_i) = Xbar(max_i) + d_tmp(max_i); %useless
    min_diff = max_ub - ( max_x - d_tmp(max_i) );
    %fprintf('%.6f\n', max_ub - ( max_x - d_tmp(max_i) ))
    min_diff_n_tmp = n_tmp;
    for b1 = (B-b):-b:0
        n_tmp(max_i) = n_tmp(max_i) - b;
        d_tmp(max_i) = sigma1 * eta ./ sqrt(n_tmp(max_i));
        n_tmp(max_ub_i) = n_tmp(max_ub_i) + b;
        d_tmp(max_ub_i) = sigma1 * eta ./ sqrt(n_tmp(max_ub_i));
        XUb_tmp(max_ub_i) = Xbar(max_ub_i) + d_tmp(max_ub_i);
        [max_ub, max_ub_i] = max(XUb_tmp(others));
        max_ub_i = others(max_ub_i);
        %fprintf('%.6f\n', max_ub - ( max_x - d_tmp(max_i) ))
        if max_ub - ( max_x - d_tmp(max_i) ) < min_diff
            min_diff = max_ub - ( max_x - d_tmp(max_i) );
            min_diff_n_tmp = n_tmp;
        end
    end
    n_tmp = min_diff_n_tmp;
    n_maxi_inc(counter) = n_tmp(max_i) - n(max_i);
    maxis(counter) = max_i;
    %n_tmp(max_i) - n(max_i)
        
    X_add = genSample(1, mu .* (n_tmp - n), sigma .* sqrt(n_tmp - n));
    Xbar = (Xbar .* n + X_add) ./ (n_tmp);
    n = n_tmp;
    d = sigma1 * eta ./ sqrt(n);
    t = t + B;
    
    [max_x, max_i] = max(Xbar);
    others = setdiff(1:k, max_i)';
    XUb = Xbar + d;
    [max_ub, max_ub_i] = max(XUb(others));
    max_ub_i = others(max_ub_i);
    
    Xbar_hist(counter, :) = Xbar;
    n_hist(counter, :) = n;
end
max_i;
sum(n);

% %% make plot
% hold on
% 
% title('Illustration of the Envelope Procedure with k = 4 systems.')
% xlim([0, 4e4])
% ylim([-1, 1])
% xlabel('n')
% 
% plot(n_hist(:,1), Xbar_hist(:,1), 'r', 'Linewidth', 1.1)
% plot(n_hist(:,1), Xbar_hist(:,1) + eta * sigma1 ./ sqrt(n_hist(:,1)), 'r--')
% plot(n_hist(:,1), Xbar_hist(:,1) - eta * sigma1 ./ sqrt(n_hist(:,1)), 'r--')
% 
% plot(n_hist(:,2), Xbar_hist(:,2), 'b', 'Linewidth', 1.1)
% plot(n_hist(:,2), Xbar_hist(:,2) + eta * sigma1 ./ sqrt(n_hist(:,2)), 'b--')
% plot(n_hist(:,2), Xbar_hist(:,2) - eta * sigma1 ./ sqrt(n_hist(:,2)), 'b--')
% 
% plot(n_hist(:,3), Xbar_hist(:,3), 'g', 'Linewidth', 1.1)
% plot(n_hist(:,3), Xbar_hist(:,3) + eta * sigma1 ./ sqrt(n_hist(:,3)), 'g--')
% plot(n_hist(:,3), Xbar_hist(:,3) - eta * sigma1 ./ sqrt(n_hist(:,3)), 'g--')
% 
% plot(n_hist(:,4), Xbar_hist(:,4), 'c', 'Linewidth', 1.1)
% plot(n_hist(:,4), Xbar_hist(:,4) + eta * sigma1 ./ sqrt(n_hist(:,4)), 'c--')
% plot(n_hist(:,4), Xbar_hist(:,4) - eta * sigma1 ./ sqrt(n_hist(:,4)), 'c--')
% 
% plot([n_hist(counter, 1), n_hist(counter, 1)], [-2, 2], 'k--')
% 
% plot([n_hist(counter,1) 4e4], [Xbar_hist(counter,1)+eta*sigma1/sqrt(n_hist(counter,1)), Xbar_hist(counter,1)+eta*sigma1/sqrt(n_hist(counter,1))], 'r:', 'Linewidth', 1)
% plot([n_hist(counter,1) 4e4], [Xbar_hist(counter,1)-eta*sigma1/sqrt(n_hist(counter,1)), Xbar_hist(counter,1)-eta*sigma1/sqrt(n_hist(counter,1))], 'r:', 'Linewidth', 1)
% 
% plot([n_hist(counter,2) 4e4], [Xbar_hist(counter,2)+eta*sigma1/sqrt(n_hist(counter,2)), Xbar_hist(counter,2)+eta*sigma1/sqrt(n_hist(counter,2))], 'b:', 'Linewidth', 1)
% plot([n_hist(counter,2) 4e4], [Xbar_hist(counter,2)-eta*sigma1/sqrt(n_hist(counter,2)), Xbar_hist(counter,2)-eta*sigma1/sqrt(n_hist(counter,2))], 'b:', 'Linewidth', 1)
% 
% plot([n_hist(counter,3) 4e4], [Xbar_hist(counter,3)+eta*sigma1/sqrt(n_hist(counter,3)), Xbar_hist(counter,3)+eta*sigma1/sqrt(n_hist(counter,3))], 'g:', 'Linewidth', 1)
% plot([n_hist(counter,3) 4e4], [Xbar_hist(counter,3)-eta*sigma1/sqrt(n_hist(counter,3)), Xbar_hist(counter,3)-eta*sigma1/sqrt(n_hist(counter,3))], 'g:', 'Linewidth', 1)
% 
% plot([n_hist(counter,4) 4e4], [Xbar_hist(counter,4)+eta*sigma1/sqrt(n_hist(counter,4)), Xbar_hist(counter,4)+eta*sigma1/sqrt(n_hist(counter,4))], 'c:', 'Linewidth', 1)
% plot([n_hist(counter,4) 4e4], [Xbar_hist(counter,4)-eta*sigma1/sqrt(n_hist(counter,4)), Xbar_hist(counter,4)-eta*sigma1/sqrt(n_hist(counter,4))], 'c:', 'Linewidth', 1)


%% make plot 2
hold on

title('Illustration of the Envelope Procedure with k = 3 systems.')
xlim([0, 1.1*counter])
ylim([-1.5, 1])
xlabel('r')

plot(1:counter, Xbar_hist(:,1), 'r', 'Linewidth', 1.2)
plot(1:counter, Xbar_hist(:,1) + eta * sigma1 ./ sqrt(n_hist(:,1)), 'r--')
plot(1:counter, Xbar_hist(:,1) - eta * sigma1 ./ sqrt(n_hist(:,1)), 'r--')

plot(1:counter, Xbar_hist(:,2), 'b', 'Linewidth', 1.2)
plot(1:counter, Xbar_hist(:,2) + eta * sigma1 ./ sqrt(n_hist(:,2)), 'b--')
plot(1:counter, Xbar_hist(:,2) - eta * sigma1 ./ sqrt(n_hist(:,2)), 'b--')

plot(1:counter, Xbar_hist(:,3), 'g', 'Linewidth', 1.2)
plot(1:counter, Xbar_hist(:,3) + eta * sigma1 ./ sqrt(n_hist(:,3)), 'g--')
plot(1:counter, Xbar_hist(:,3) - eta * sigma1 ./ sqrt(n_hist(:,3)), 'g--')

% plot(1:counter, Xbar_hist(:,4), 'c', 'Linewidth', 1.1)
% plot(1:counter, Xbar_hist(:,4) + eta * sigma1 ./ sqrt(n_hist(:,4)), 'c--')
% plot(1:counter, Xbar_hist(:,4) - eta * sigma1 ./ sqrt(n_hist(:,4)), 'c--')

plot([counter, counter], [-2, 2], 'k--')

plot([counter 1.1*counter], [Xbar_hist(counter,1)+eta*sigma1/sqrt(n_hist(counter,1)), Xbar_hist(counter,1)+eta*sigma1/sqrt(n_hist(counter,1))], 'r:', 'Linewidth', 1)
plot([counter 1.1*counter], [Xbar_hist(counter,1)-eta*sigma1/sqrt(n_hist(counter,1)), Xbar_hist(counter,1)-eta*sigma1/sqrt(n_hist(counter,1))], 'r:', 'Linewidth', 1)

plot([counter 1.1*counter], [Xbar_hist(counter,2)+eta*sigma1/sqrt(n_hist(counter,2)), Xbar_hist(counter,2)+eta*sigma1/sqrt(n_hist(counter,2))], 'b:', 'Linewidth', 1)
plot([counter 1.1*counter], [Xbar_hist(counter,2)-eta*sigma1/sqrt(n_hist(counter,2)), Xbar_hist(counter,2)-eta*sigma1/sqrt(n_hist(counter,2))], 'b:', 'Linewidth', 1)

plot([counter 1.1*counter], [Xbar_hist(counter,3)+eta*sigma1/sqrt(n_hist(counter,3)), Xbar_hist(counter,3)+eta*sigma1/sqrt(n_hist(counter,3))], 'g:', 'Linewidth', 1)
plot([counter 1.1*counter], [Xbar_hist(counter,3)-eta*sigma1/sqrt(n_hist(counter,3)), Xbar_hist(counter,3)-eta*sigma1/sqrt(n_hist(counter,3))], 'g:', 'Linewidth', 1)

% plot([counter 1.1*counter], [Xbar_hist(counter,4)+eta*sigma1/sqrt(n_hist(counter,4)), Xbar_hist(counter,4)+eta*sigma1/sqrt(n_hist(counter,4))], 'c:', 'Linewidth', 1)
% plot([counter 1.1*counter], [Xbar_hist(counter,4)-eta*sigma1/sqrt(n_hist(counter,4)), Xbar_hist(counter,4)-eta*sigma1/sqrt(n_hist(counter,4))], 'c:', 'Linewidth', 1)





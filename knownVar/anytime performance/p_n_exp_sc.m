n_max = 2e6;
unit = 100;
iter_max = 2000;

tic
bsize = 10;
p_n_EP1 = zeros(1, n_max / unit);
for iter = 1:iter_max
    c_n_t = -1 * ones(1, n_max / unit);
    EP1_known;
    p_n_EP1 = p_n_EP1 + c_n_t;
    if mod(iter, iter_max/100) == 0
        iter
        toc
    end
end
p_n_EP1 = p_n_EP1 / iter_max;

tic
bsize = 10;
p_n_BIZ = zeros(1, n_max / unit);
for iter = 1:iter_max
    c_n_t = -1 * ones(1, n_max / unit);
    BIZ_known_comVar;
    p_n_BIZ = p_n_BIZ + c_n_t;
    if mod(iter, iter_max/100) == 0
        iter
        toc
    end
end
p_n_BIZ = p_n_BIZ / iter_max;

tic
p_n_KN = zeros(1, n_max / unit);
for iter = 1:iter_max
    c_n_t = -1 * ones(1, n_max / unit);
    KN_known_comVar;
    p_n_KN = p_n_KN + c_n_t;
    if mod(iter, iter_max/100) == 0
        iter
        toc
    end
end
p_n_KN = p_n_KN / iter_max;

tic
p_n_OCBA = zeros(1, n_max / unit);
for iter = 1:iter_max
    c_n_t = -1 * ones(1, n_max / unit);
    OCBA_known_comVar;
    p_n_OCBA = p_n_OCBA + c_n_t;
    if mod(iter, iter_max/100) == 0
        iter
        toc
    end
end
p_n_OCBA = p_n_OCBA / iter_max;

figure
hold on
plot((1:n_max / unit)*unit, p_n_EP1, 'b');
plot((1:n_max / unit)*unit, p_n_BIZ, 'r');
plot((1:n_max / unit)*unit, p_n_KN, 'g');
plot((1:n_max / unit)*unit, p_n_OCBA, 'k');

legend('EP', 'BIZ', 'KN', 'OCBA', 'Location', 'SouthEast')
xlabel('n')
ylabel('PAC')

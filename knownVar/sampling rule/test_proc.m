max_iter = 1000;
sumn = zeros(1, max_iter);
correct = zeros(1, max_iter);
tic
for iter = 1:max_iter
    if mod(iter, max_iter/10) == 0
        iter
        toc
    end
    set_config;
    EP_test;
    sumn(iter) = sum(n);
    correct(iter) = mu(max_i) > mu(k) - delta;
end
toc
mean(sumn)
mean(correct)
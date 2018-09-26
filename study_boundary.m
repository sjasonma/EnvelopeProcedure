n = 100;
k = 100000;
W = cumsum(randn(k,n)')';
U = W ./ (ones(k,1) * sqrt(1:n));

mean(max(U')>4)

cut = 2;
m = max(U(:,1:cut)')';
%m = U(:,1);
m_sort = sort(m);


u = U(m<1,cut+1);
hist(u, 100);


%%
hold on
for i = 1:k
    plot(U(i,:));
end
%%

n = 1000;
eta =4;
x = [-10:0.1:eta];
u = zeros(n, length(x));
u(1, :) = normpdf(x) / normcdf(eta);
hold on
for i = 2 : n
    for j = 1:length(x)
        u(i, j) = u(i-1,:) * normpdf(sqrt(i)*x(j) - sqrt(i-1)*x)';
    end
    u(i, :) = u(i, :) / sum(u(i, :)) / 0.1;
    plot(u(i, :));
end
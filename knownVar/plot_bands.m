plot([0, k], [max_x - d(max_i), max_x - d(max_i)], 'r-.')
hold on
plot([0, k], [max_x - d(max_i) + delta, max_x - d(max_i) + delta], 'k-.')
for i = 1:k
    if i == max_i
        errorbar(i, Xbar(i), d(i), 'rx');
    elseif XUb(i) > ( max_x - d(max_i) ) + delta
        errorbar(i, Xbar(i), d(i), 'b');
    end
end
hold off
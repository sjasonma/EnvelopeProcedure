function p = computeProb(y, eta_i)
fun = @(y_i) computeProb_1(y_i, eta_i);
p = arrayfun(fun, y);
end

function p = computeProb_1(y, eta_i)
if y <= eta_i(1)
    p = 0;
elseif y > eta_i(end)
    p = 1;
else
p = min(find(eta_i > y)) / length(eta_i);
end
end
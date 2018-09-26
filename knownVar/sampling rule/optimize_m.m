l_l = max(max(Xbar(others)) - delta, max_x - d(max_i));
l_r = max_x;
l_d = (l_r - l_l) / 10;

%hold on
min_m = inf;
for l = l_l: l_d: (l_r - l_d)
    m = max((eta * sigma ./ (l + delta - Xbar)).^2 - n, 0);
    m(max_i) = (eta * sigma(max_i) / (Xbar(max_i) - l))^2 - n(max_i);
    sum(m);
    %plot(l, sum(m), 'b*');
    if sum(m) > min_m
        l = l - l_d;
        break;
    end
    min_m = sum(m);
end
m = max((eta * sigma ./ (l + delta - Xbar)).^2 - n, 0);
m(max_i) = max((eta * sigma(max_i) / (Xbar(max_i) - l))^2 - n(max_i), 0);
m = m / sum(m) * B;
m = ceil(m);
% if sum(rm) < B / 2
%     sm = sort(m, 'descend');
%     m(m >= sm(B - sum(rm))) = m(m >= sm(B - sum(rm))) + 1;
%     m = round(m);
% else
%     m = rm;
% end
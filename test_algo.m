max_i_s = [];
totalsim = [];
true_best = 101;
i_lim = 1000;
wb = waitbar(0,sprintf('0/%d, 0%% completed.', i_lim));
for i = 1:i_lim
    algo7;
    max_i_s(i) = max_i;
    totalsim(i) = sum(n);
    waitbar(i/i_lim, wb, sprintf('%d/%d, %.1f%% completed.', i, i_lim, i/i_lim*100));
end
close(wb);

sum(max_i_s>=990) / i_lim
mean(totalsim)
min(totalsim)
max(totalsim)
std(totalsim)
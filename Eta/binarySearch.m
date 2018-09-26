function mid = binarySearch(func, th, lb, ub, delta, ifinc)
if ~ifinc
    func = @(x) -func(x);
    th = -th;
end
while func(lb) > th
    lb = lb / 2;
end
delta = min(delta, lb);
while func(ub) < th
    ub = ub * 2;
end
while lb < ub - delta
    mid = (lb + ub) / 2;
    if func(mid) < th
        lb = mid;
    else
        ub = mid;
    end
end
mid = (lb + ub) / 2;
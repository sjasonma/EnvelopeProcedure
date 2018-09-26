function c = findC(m)
c = 0;
while c < 1
    c = c + 0.001;
    if funcP(c, m) < 0
        return
    end
end
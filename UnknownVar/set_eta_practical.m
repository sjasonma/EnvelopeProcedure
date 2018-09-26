if k == 10
    eta_EP = 2.65;
    eta_EPp = 2.65;
elseif k == 100
    eta_EP = 2.77;
    eta_EPp = 2.77;
    % 2.8
    % 2.75
elseif k == 1000
    eta_EP = 2.83;
    eta_EPp = 2.83;
    % 2.9
    % 2.85
elseif k == 10000
    eta_EP = 2.92;
    eta_EPp = 2.92;
    % 3.1
    % 2.95
else
    disp('No NP_eta corresponding to k!')
end

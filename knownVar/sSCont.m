%   ***************************************
%   *** Code written by German Gutierrez***
%   ***         gg92@cornell.edu        ***
%   ***   Edited by Jennifer Shih       ***
%   ***       jls493@cornell.edu        ***
%   ***************************************
%
%   Last updated August 2, 2014 

%RETURNS:  Avg. and C.I. half width for per period cost and the stockout
%rate. Currently set to 20 repetitions of 10000 days each (50 day warmup).

function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSCont(x, runlength, nRepetitions, seed, ~)
% function [fn, FnVar, FnGrad, FnGradCov, constraint, ConstraintCov, ConstraintGrad, ConstraintGradCov] = sSCont(x, runlength, seed, other);
% x is the (s, S) vector
% runlength is the number of days of demand to simulate
% seed is the index of the substreams to use (integer >= 1)
% other is not used
%runlength must be greater than 50 (warmup period) 
%Note: RandStream.setGlobalStream(stream) can only be used for Matlab
%versions 2011 and later
%For earlier versions, use the method RandStream.setDefaultStream(stream)
%

FnGrad = NaN;
FnGradCov = NaN;    
ConstraintGrad = NaN;
ConstraintGradCov = NaN;

if (sum(x < 0)> 0 )|| (runlength <= 0) || (runlength ~= round(runlength)) || (seed <= 0) || (round(seed) ~= seed)
    fprintf('x should be >= 0, runlength should be positive integer, seed must be a positive integer\n');
    fn = NaN;
    FnVar = NaN;
    constraint = NaN;
	ConstraintCov = NaN;
elseif (x(1)>=x(2))
    fprintf('S must be greater than s\n');
    fn = NaN;
    FnVar = NaN;
    constraint = NaN;
    ConstraintCov = NaN;

else
%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%%
nRepetitions;                 %Repetitions
meanDemand = 100;                  %Mean demand
meanLT = 6;                        %Mean lead time
fixed = 36;                        %Fixed order cost
varc = 2;                           %Variable, per unit, cost
holding = 1;                       % Holding cost
warmup = 50;                       %length of warm up period
nDays = runlength+warmup;          %Length of simulation: 10050

%%%%%%%%Decision Variables%%%%%%%%%
s=x(1);
S=x(2); %[1000 2000] starting Sol

    % Generate new streams for 
    [DemandStream, LeadTimeStream] = RandStream.create('mrg32k3a', 'NumStreams', 2);

    % Set the substream to the "seed"
    DemandStream.Substream = seed;
    LeadTimeStream.Substream = seed;

    % Generate demands
    OldStream = RandStream.setGlobalStream(DemandStream);
    %OldStream = RandStream.setDefaultStream(DemandStream); %versions 2010 and earlier
    Dem=exprnd(meanDemand, nRepetitions, nDays);
    
    % Generate lead times
    RandStream.setGlobalStream(LeadTimeStream);
    %RandStream.setDefaultStream(LeadTimeStream); %versions 2010 and earlier
    LT=poissrnd(meanLT, nRepetitions, nDays);
    
    RandStream.setGlobalStream(OldStream); % Restore previous stream
    %RandStream.setDefaultStream(OldStream); %versions 2010 and earlier


Output = zeros(2,nRepetitions);
Inv = zeros(nRepetitions, nDays);
for j =1:nRepetitions

    %Vector tracks outstanding orders. Row 1: day of delivery and row 2: quantity.
    Orders = zeros(2,1);
    InvOH = 1500;
    %Variables to estimate service level constraint.
    nUnits = 0;
    nLate = 0;

    TotalCost = 0;
    
    for i=1:nDays
        Inv(j,i) = InvOH; 
        
        %Receive orders
        if length(Orders(1,:)) > 1
            [C,I] = min(Orders(1,2:length(Orders(1,:))));
            while( C == i)
                InvOH = InvOH + Orders(2,I+1);
                Orders(:,I+1) = [];
                C = 0;
                I = 0;
                if length(Orders(1,:)) > 1
                    [C,I] = min(Orders(1,2:length(Orders(1,:))));
                end
            end
        end
        

        %Satisfy or backorder demand
        Demand = Dem(j,i);
        InvOH = InvOH - Demand;
        if(i > warmup)
            nUnits = nUnits + Demand;
            if InvOH < 0
                nLate = nLate + min(Demand, -InvOH);
            end
        end
        
        
        %Calculate Inventory Position and place orders.
        IP = InvOH + sum(Orders(2,:));
        if( IP < s )
            leadTime = LT(j,i);
            x = S-IP;
            Orders = [Orders, [i+leadTime+1; x]];
            if ( i > warmup)
                TotalCost= TotalCost + fixed + x*varc;
            end
        end
        
        if ( i > warmup)
            TotalCost = TotalCost + holding*max(InvOH, 0);
        end           
    end

Output(1,j) = TotalCost/(nDays-warmup);
Output(2,j) = nLate/nUnits;

end
%First row has mean cost, second has stockout rate:
fn = mean(Output(1,:));
test = var(Output(1,:));
nRepetitions;
FnVar= var(Output(1,:))/nRepetitions;
constraint = mean(Output(2,:))-.1; % Constraint not satisfied if this is positive
ConstraintCov = var(Output(2,:))/nRepetitions;

%CIHalfWidth = 1.96 * (std(Output')/sqrt(nRepetitions))'

end
end


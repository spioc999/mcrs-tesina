function [isFree] = isFreeEdge(from, to, obstacles, alpha, checkOnBorder) 

if nargin < 4
    alpha = 0.05;
end

if nargin < 5
    checkOnBorder = false;
end

pace = 0:alpha:1;
i = 1;
exitCondition = false;
isFree = true;

while(not(exitCondition))
    x = pace(i)*from(1) + (1-pace(i))*to(1);
    y = pace(i)*from(2) + (1-pace(i))*to(2);

    isFree = isFreePoint([x y], obstacles, checkOnBorder);

    exitCondition = i >= length(pace) || not(isFree);

    i = i+1;
end    

end
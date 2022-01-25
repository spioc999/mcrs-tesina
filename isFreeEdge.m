function [isFree] = isFreeEdge(from, to, obstacles, alphaValue, checkOnBorder) 

if nargin < 4 || size(alphaValue, 1) == 0
    alphaValue = 1/(round(norm(from - to)) * 100); % 100 points each unit
end

if nargin < 5
    checkOnBorder = false;
end

pace = 0:alphaValue:1;
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
function [isFree] = isFreePoint(p, obstacles, checkOnBorder)
    if nargin < 3
        checkOnBorder = false;
    end
    
    isFree = true;
    exitCondition = false;
    i=1;
    while(not(exitCondition))
        if checkOnBorder
            insideOfARectangle = p(1)>=obstacles(i, 1) &&...
                p(1)<=(obstacles(i, 1) + obstacles(i, 3)) &&...
                p(2)>=obstacles(i, 2) &&...
                p(2)<=(obstacles(i, 2) + obstacles(i, 4));
        else
            insideOfARectangle = p(1)>obstacles(i, 1) &&...
                p(1)<(obstacles(i, 1) + obstacles(i, 3)) &&...
                p(2)>obstacles(i, 2) &&...
                p(2)<(obstacles(i, 2) + obstacles(i, 4));
        end
    
        if insideOfARectangle
            isFree = false;
        end
    
        exitCondition = i >= size(obstacles, 1) || not(isFree);
        i = i+1;
    end
end

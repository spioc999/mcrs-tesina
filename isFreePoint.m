function [isFree] = isFreePoint(p, obstacles)
    isFree = true;
    exitCondition = false;
    i=1;
    while(not(exitCondition))
        insideOfARectangle = p(1)>=obstacles(i, 1) & ...
            p(1)<=(obstacles(i, 1) + obstacles(i, 3)) & ...
            p(2)>=obstacles(i, 2) & ...
            p(2)<=(obstacles(i, 2) + obstacles(i, 4));
    
        if insideOfARectangle
            isFree = false;
        end
    
        exitCondition = i >= size(obstacles, 1) || not(isFree);
        i = i+1;
    end
end

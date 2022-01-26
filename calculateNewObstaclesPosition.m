function [positionsOutput, directionsOutput, deltasOutput] = calculateNewObstaclesPosition(positions, movementsEnabled, directions, deltas)

positionsOutput = [];
directionsOutput = [];
deltasOutput = [];
fountain = [4 4 2 2];

for i=1:size(positions, 1)
    xOutput = positions(i, 1);
    yOutput = positions(i, 2);
    directionOutput = directions(i);
    deltaOutput = deltas(i);
    w = positions(i, 3);
    h = positions(i, 4);

    if movementsEnabled(i)
        [x, y] = moveElement(xOutput, yOutput, directionOutput, deltaOutput);
        xOutput = x;
        yOutput = y;
        
        [isOverflow, xOverflow, yOverflow] = checkOverflowWithBorders(xOutput, yOutput, w, h);
        
        if isOverflow
            xOutput = xOutput - xOverflow;
            yOutput = yOutput - yOverflow;
        
            if or(directionOutput == 0, directionOutput == 2)
                deltaOutput = -deltaOutput;
            else
                if yOverflow ~= 0
                    deltaOutput = -deltaOutput;
                end
        
                if directionOutput == 1
                    directionOutput = 3;
                elseif directionOutput == 3
                    directionOutput = 1;
                end
            end
        end
        
        isColliding = checkCollisionWithObstacles(xOutput, yOutput, w, h, fountain);
        if isColliding
            if or(directionOutput == 0, directionOutput == 2)
                deltaOutput = -deltaOutput;
            else
                if directionOutput == 1
                    directionOutput = 3;
                elseif directionOutput == 3
                    directionOutput = 1;
                end
            end
            [x, y] = moveElement(xOutput, yOutput, directionOutput, deltaOutput);
            isCollidingAgain = checkCollisionWithObstacles(x, y, w, h, fountain);
            if isCollidingAgain
                deltaOutput = -deltaOutput;
                [x, y] = moveElement(xOutput, yOutput, directionOutput, deltaOutput);
            end
            xOutput = x;
            yOutput = y;
        end
    end
    positionsOutput = cat(1, positionsOutput, [xOutput yOutput w h]);
    directionsOutput = cat(1, directionsOutput, directionOutput);
    deltasOutput = cat(1, deltasOutput, deltaOutput);
end

end



function [xOutput, yOutput] = moveElement(xInput, yInput, direction, delta)

switch direction
    case 0
        xOutput = xInput;
        yOutput = yInput + delta;
    case 1
        xOutput = xInput + delta * cos(pi/4);
        yOutput = yInput + delta * sin(pi/4);
    case 2
        xOutput = xInput + delta;
        yOutput = yInput;
    case 3
        xOutput = xInput + delta * (-cos(pi/4));
        yOutput = yInput + delta * sin(pi/4);
    otherwise
        error('Direction value not allowed! Only integer values in range 0-3');
end

end


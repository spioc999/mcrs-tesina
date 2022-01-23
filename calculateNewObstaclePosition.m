function [xOutput, yOutput, directionOutput, deltaOutput] = calculateNewObstaclePosition(xInput, yInput, w, h, directionInput, deltaInput, limit)

switch directionInput
    case 0
        xOutput = xInput;
        yOutput = yInput + deltaInput;
    case 1
        xOutput = xInput + deltaInput * cos(pi/4);
        yOutput = yInput + deltaInput * sin(pi/4);
    case 2
        xOutput = xInput + deltaInput;
        yOutput = yInput;
    case 3
        xOutput = xInput + deltaInput * (-cos(pi/4));
        yOutput = yInput + deltaInput * sin(pi/4);
    otherwise
        error('Direction value not allowed! Only integer values in range 0-3');
end

directionOutput = directionInput;
deltaOutput = deltaInput;

[isOverflow, xOverflow, yOverflow] = checkOverflowWithBorders(limit, xOutput, yOutput, w, h);

if isOverflow
    xOutput = xOutput - xOverflow;
    yOutput = yOutput - yOverflow;

    if or(directionInput == 0, directionInput == 2)
        deltaOutput = -deltaInput;
    else
        if yOverflow ~= 0
            deltaOutput = -deltaInput;
        end

        if directionInput == 1
            directionOutput = 3;
        elseif directionInput == 3
            directionOutput = 1;
        end
    end
end

end


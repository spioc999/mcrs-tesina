function [rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta, rectanglesColor] = getInitialConfig(filePath)
    rectanglesPosition = [];
    rectanglesMovementEnabled = [];
    rectanglesDirection = []; 
    rectanglesDelta = [];
    rectanglesColor = [];

    fileLines = skipHeader(readlines(filePath));
    for lineNumber=1:size(fileLines, 1)
        rectanglesPosition = cat(1, rectanglesPosition, getRectanglePosition(fileLines(lineNumber, 1:4), rectanglesPosition));
        rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, getRectangleMovementEnabled(fileLines(lineNumber, 5)));
        rectanglesDirection = cat(1, rectanglesDirection, getRectangleDirection(fileLines(lineNumber, 6)));
        rectanglesDelta = cat(1, rectanglesDelta, getRectangleDelta(fileLines(lineNumber, 7)));
        rectanglesColor = cat(1, rectanglesColor, cat(2, rand(1, 3), 0.5));
    end
end

function [fixedFileLines] = skipHeader(fileLines)
    fixedFileLines = [];
    for lineNumber=1:size(fileLines, 1)
        lineElements = split(fileLines(lineNumber));
        if not(strcmp(lineElements(1), "")) && not(contains(lineElements(1), '#'))
            fixedFileLines = cat(1, fixedFileLines, lineElements');
        end
    end
end

function [rectanglesPosition] = getRectanglePosition(lineData, allRectangles)
    fountain = [4 4 2 2];
    % Set up a collision block in order to enter the while
    skipCheck = true;
    while skipCheck || checkCollisionWithObstacles(x, y, w, h, cat(1, allRectangles, fountain))
        x = getValueFromStringOrRandomInRange(lineData(1), 0, 9, 'float');
        y = getValueFromStringOrRandomInRange(lineData(2), 0, 9, 'float');
        w = getValueFromStringOrRandomInRange(lineData(3), 1, min([4, 10-x]), 'float'); 
        h = getValueFromStringOrRandomInRange(lineData(4), 1, min(4, 10-y), 'float');
        skipCheck = false;
    end
    rectanglesPosition = [x y w h];
end

function [rectangleMovementEnabled] = getRectangleMovementEnabled(lineData)
    rectangleMovementEnabled = getValueFromStringOrRandomInRange(lineData, 0, 1, 'int');
    if rectangleMovementEnabled > 1 || rectangleMovementEnabled < 0
        error("MovementEnabled, in config file, must be 0 or 1.")
    end
end

function [rectangleDirection] = getRectangleDirection(lineData)
    rectangleDirection = getValueFromStringOrRandomInRange(lineData, 0, 3, 'int');
    if rectangleDirection > 3 || rectangleDirection < 0
        error("Direction must be a value from 0 to 3.");
    end
end

function [rectangleDelta] = getRectangleDelta(lineData)
    rectangleDelta = getValueFromStringOrRandomInRange(lineData, -1, 1, 'float');
    if rectangleDelta < -1 || rectangleDelta > 1
        error("Delta must be a value from -1 to 1.");
    end
end

function [value] = getValueFromStringOrRandomInRange(strValue, rangeInit, rangeEnd, randType)
    if strcmp(strValue, '*')
        if not(strcmp(randType, 'int'))
            value = (rangeEnd-rangeInit).*rand + rangeInit;
        else
            value = randi([rangeInit, rangeEnd]);
        end
    else
        value = str2double(strValue);
    end
end


function [rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig(filePath)
    FID = fopen(filePath);
    skipFileHeader(FID)
    rectanglesConfig = fscanf(FID, '%f %f %f %f %d %d %f');
    rectanglesPosition = getRectanglesPosition(rectanglesConfig);
    rectanglesMovementEnabled = rectanglesConfig(5:7:end);
    rectanglesDirection = rectanglesConfig(6:7:end);
    rectanglesDelta = rectanglesConfig(7:7:end);
end


function [] = skipFileHeader(FID)
    readedLine = fgetl(FID);
    firstChar = readedLine(1);
    while firstChar == '#'
        readedLine = fgetl(FID);
        if strlength(readedLine) > 0
            firstChar = readedLine(1);
        else
            firstChar = readedLine;
        end
    end
    if not(strcmp(readedLine, ''))
        error('Config file wrong format. You must leave an empty line before the configuration.')
    end
end

function [rectanglesPosition] = getRectanglesPosition(rectanglesConfig)
    rectanglesPosition = [rectanglesConfig(1:7:end), rectanglesConfig(2:7:end), rectanglesConfig(3:7:end), rectanglesConfig(4:7:end)];
end

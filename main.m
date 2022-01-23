close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/config.txt");


while true
    placeObstacles(rectanglesPosition);
    for i=1:size(rectanglesPosition, 1)
        if rectanglesMovementEnabled(i) == 1
            [x, y, dir, del] = calculateNewObstaclePosition(rectanglesPosition(i, 1), rectanglesPosition(i, 2), rectanglesPosition(i, 3), rectanglesPosition(i, 4), rectanglesDirection(i), rectanglesDelta(i));
            rectanglesPosition(i, 1) = x;
            rectanglesPosition(i, 2) = y;
            rectanglesDirection(i) = dir;
            rectanglesDelta(i) = del;
        end
    end
    pause(0.05);
end
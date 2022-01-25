close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])

%Idea: if not(isPathAvailable(currentPath)
% Then findPath(currentPosition, destination)

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/config.txt");

while true
    placeObstacles(rectanglesPosition);
    [positions, directions, deltas] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
    rectanglesPosition = positions;
    rectanglesDirection = directions;
    rectanglesDelta = deltas;
    pause(0.05);
end

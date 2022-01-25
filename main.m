close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])

fountains = [4 4 2 2];
fountainsMovementEnabled = 0;

%TODO: refactoring from rectangle to obstacle
% PROBLEM: Fountain is not included in list of obstacles

%Idea: if not(isPathAvailable(currentPath)
% Then findPath(currentPosition, destination)

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/config.txt");
rectanglesPosition = cat(1, rectanglesPosition, fountains);
rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, fountainsMovementEnabled);
rectanglesDirection = cat(1, rectanglesMovementEnabled, 0);
rectanglesDelta = cat(1, rectanglesDelta, 0);

currentPosition = [0 0];
destination = [10 10];


% donePath = animatedline('Color','b','LineWidth',3);
% toDotPath = animatedline('Color','r','LineWidth',3);

while not(currentPosition == destination)
%     pathToDestination = findPath(currentPosition, destination, rectanglesPosition);
%     clearpoints(toDotPath);
%     addpoints(toDotPath, pathToDestination(:, 1), pathToDestination(:,2));
%     addpoints(donePath, currentPosition(1), currentPosition(2));
%     drawnow;
    placeObstacles(rectanglesPosition);
    
    [rectanglesPosition, rectanglesDirection, rectanglesDelta] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
%     currentPosition = pathToDestination(2, :);
    pause(0.1);
end




% while true
%     placeObstacles(rectanglesPosition);
%     [positions, directions, deltas] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
%     rectanglesPosition = positions;
%     rectanglesDirection = directions;
%     rectanglesDelta = deltas;
%     pause(0.05);
% end

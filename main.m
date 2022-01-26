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

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/random.txt");
rectanglesPosition = cat(1, rectanglesPosition, fountains);
rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, fountainsMovementEnabled);
rectanglesDirection = cat(1, rectanglesMovementEnabled, 0);
rectanglesDelta = cat(1, rectanglesDelta, 0);

currentPosition = [0 0];
destination = [10 10];


donePath = animatedline('Color','b','LineWidth',3);
toDoPath = animatedline('Color','r','LineWidth',3);

pathToDestination = findPath(currentPosition, destination, rectanglesPosition);
placeObstacles(rectanglesPosition);
addpoints(toDoPath, pathToDestination(:, 1), pathToDestination(:,2));
addpoints(donePath, currentPosition(1), currentPosition(2));
drawnow;

while not(currentPosition == destination)
    tic
    [rectanglesPosition, rectanglesDirection, rectanglesDelta] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
    pathToDestination = findPath(currentPosition, destination, rectanglesPosition);
    if size(pathToDestination, 1) > 1
        currentPosition = pathToDestination(2, :);
    elseif size(pathToDestination, 1) == 1 && not(isequal(currentPosition, pathToDestination))
        currentPosition = pathToDestination(1, :);
    end
    pathToDestination(1, :) = [];
    clearpoints(toDoPath);
    placeObstacles(rectanglesPosition);
    addpoints(donePath, currentPosition(1), currentPosition(2));
    addpoints(toDoPath, pathToDestination(:, 1), pathToDestination(:,2));
    remainingWaitTime = 0.5 - toc;
    if remainingWaitTime > 0
        pause(remainingWaitTime);
    end
end


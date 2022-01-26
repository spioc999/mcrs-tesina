close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])
hold on

%TODO: refactoring from rectangle to obstacle

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/random.txt");
[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);

[currentPosition, initArea, destination, donePath, toDoPath] = initVariables();

pathToDestination = findPath(currentPosition, destination, initArea, rectanglesPosition);
currentPositionPlot = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, []);
pause(2); % Wait in order to evaluate the field

while not(currentPosition == destination)
    tic % Starting peace of code time count
    [currentPosition, pathToDestination, initArea] = updateCurrentPosition(currentPosition, pathToDestination, initArea);
    [rectanglesPosition, rectanglesDirection, rectanglesDelta] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
    
    if not(isPathAvailable(pathToDestination, rectanglesPosition))
        pathToDestination = findPath(currentPosition, destination, initArea, rectanglesPosition);
    end
    currentPositionPlot = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, currentPositionPlot);
    calculateWaitTimeAndWait();
end

%% Start functions section

function [currentPosition, pathToDestination, initArea] = updateCurrentPosition(currentPosition, pathToDestination, initArea)
    if size(pathToDestination, 1) > 1
        currentPosition = pathToDestination(2, :);
        initArea = currentPosition;
    elseif size(pathToDestination, 1) == 1 && not(isequal(currentPosition, pathToDestination))
        currentPosition = pathToDestination(1, :);
        initArea = currentPosition;
    else
        initArea(1) = initArea(1) - 0.5;
        initArea(2) = initArea(2) - 0.5;
        if initArea(1) < 0
            initArea(1) = 0;
        end
        if initArea(2) < 0
            initArea(2) = 0;
        end
    end
    if not(isempty(pathToDestination))
        pathToDestination(1, :) = [];
    end
end


function [currentPositionPlot] = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, currentPositionPlot)
    clearpoints(toDoPath);
    placeObstacles(rectanglesPosition);
    addpoints(donePath, currentPosition(1), currentPosition(2));
    addpoints(toDoPath, pathToDestination(:, 1), pathToDestination(:,2));
    if not(isempty(currentPositionPlot))
        delete(currentPositionPlot)
    end
    currentPositionPlot = plot(currentPosition(1), currentPosition(2), 'Marker','o', 'MarkerSize',10, 'MarkerFaceColor','b');
end


function [rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta)
    rectanglesPosition = cat(1, rectanglesPosition, [4 4 2 2]);
    rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, 0);
    rectanglesDirection = cat(1, rectanglesDirection, 0);
    rectanglesDelta = cat(1, rectanglesDelta, 0);
end

function [currentPosition, initArea, destination, donePath, toDoPath] = initVariables()
    currentPosition = [0 0];
    initArea = currentPosition;
    destination = [10 10];
    donePath = animatedline('Color','b', 'LineWidth',3);
    toDoPath = animatedline('Color','r','LineWidth',3);
end

function [remainingWaitTime] = calculateWaitTimeAndWait()
    remainingWaitTime = 1 - toc;
    if remainingWaitTime > 0
        pause(remainingWaitTime);
    end
end


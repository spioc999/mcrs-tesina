close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])
hold on

%TODO: refactoring from rectangle to obstacle

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta, rectanglesColor] = getInitialConfig("config_files/random.txt");
[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);

[currentPosition, initArea, endArea, donePath, toDoPath] = initVariables();


[destinations] = findDestinations(5, rectanglesPosition);
[destination, destinationPlot, destinations] = drawDestination([], [], destinations);


pathToDestination = findPath(currentPosition, destination, initArea, endArea, rectanglesPosition);
currentPositionPlot = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, []);
pause(2); % Wait in order to evaluate the field

while not(isempty(destinations))
    tic % Starting peace of code time count
    [currentPosition, pathToDestination, initArea, endArea] = updateCurrentPosition(currentPosition, destination, pathToDestination, initArea, endArea);
    [rectanglesPosition, rectanglesDirection, rectanglesDelta] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
    
    if isequal(currentPosition, pathToDestination) || not(isPathAvailable(pathToDestination, rectanglesPosition))
        pathToDestination = findPath(currentPosition, destination, initArea, endArea, rectanglesPosition);
    end
    currentPositionPlot = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, currentPositionPlot);
    if isequal(currentPosition, destination)
        [destination, destinationPlot, destinations] = drawDestination(destination, destinationPlot, destinations);
        endArea = destination;
    end
    calculateWaitTimeAndWait();
end


%% Start functions section

function [currentPosition, pathToDestination, initArea, endArea] = updateCurrentPosition(currentPosition, destination, pathToDestination, initArea, endArea)
    initAreaEqualPosition = false;
    if size(pathToDestination, 1) > 1
        currentPosition = pathToDestination(2, :);
        initAreaEqualPosition = true;
    elseif size(pathToDestination, 1) == 1 && not(isequal(currentPosition, pathToDestination))
        currentPosition = pathToDestination(1, :);
        initAreaEqualPosition = true;
    end

    if initAreaEqualPosition
        [initArea, endArea] = calculateArea(currentPosition, destination, false, [], []);
    else
        [initArea, endArea] = calculateArea(currentPosition, destination, true, initArea, endArea);
    end
    if not(isempty(pathToDestination))
        pathToDestination(1, :) = [];
    end

end


function [currentPositionPlot] = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, currentPositionPlot)
    clearpoints(toDoPath);
    placeObstacles(rectanglesPosition, rectanglesColor);
    addpoints(donePath, currentPosition(1), currentPosition(2));
    addpoints(toDoPath, pathToDestination(:, 1), pathToDestination(:,2));
    if not(isempty(currentPositionPlot))
        delete(currentPositionPlot)
    end
    currentPositionPlot = plot(currentPosition(1), currentPosition(2), 'Marker','o', 'MarkerSize',10, 'MarkerEdgeColor', 'blue' ,'MarkerFaceColor','b');
end


function [rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta)
    rectanglesPosition = cat(1, rectanglesPosition, [4 4 2 2]);
    rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, 0);
    rectanglesDirection = cat(1, rectanglesDirection, 0);
    rectanglesDelta = cat(1, rectanglesDelta, 0);
end

function [currentPosition, initArea, endArea, donePath, toDoPath] = initVariables()
    currentPosition = [0 0];
    initArea = currentPosition;
    endArea = [10 10];
    donePath = animatedline('Color','b', 'LineWidth',3);
    toDoPath = animatedline('Color','r','LineWidth',3, 'LineStyle',':');
    plot(0, 0, 'Marker','s', 'MarkerEdgeColor','blue', 'MarkerSize',30, 'LineWidth',2); %Start
end

function [remainingWaitTime] = calculateWaitTimeAndWait()
    remainingWaitTime = 1 - toc;
    if remainingWaitTime > 0
        pause(remainingWaitTime);
    end
end

function [destinations] = findDestinations(destinationsNumber, obstacles)
    destinations = [];
    for i=1:destinationsNumber-1
        skipCheck = true;
        while skipCheck || not(isFreePoint(possibleDestination, obstacles, true))
            possibleDestination = 10.*rand(1,2);
            skipCheck = false;
        end
        destinations = cat(1, destinations, possibleDestination);
    end
    destinations = cat(1, destinations, [10 10]);
end

function [currentDestination, destinationPlot, destinations] = drawDestination(currentDestination, destinationPlot, destinations)
    oldDestination = currentDestination; 
    if not(isempty(destinationPlot))
        destinations(1, :) = [];
        if isempty(destinations)
            destinations = [];
        end
        delete(destinationPlot);
        plot(oldDestination(1, 1), oldDestination(1, 2), 'Marker','s', 'MarkerEdgeColor','blue', 'MarkerSize', 30, 'LineWidth',2);
    end
    if not(isempty(destinations))
        currentDestination = destinations(1, :);
        destinationPlot = plot(currentDestination(1,1), currentDestination(1,2), 'Marker','s', 'MarkerEdgeColor','red', 'MarkerSize', 30, 'LineWidth',2);
    end
end

function [initArea, endArea] = calculateArea(currentPosition, destination, expandArea, initArea, endArea)
    if isempty(expandArea) || not(expandArea)
        initArea = [min(currentPosition(1), destination(1)) min(currentPosition(2), destination(2))];
        endArea = [max(currentPosition(1), destination(1)) max(currentPosition(2), destination(2))];
    else
        initArea = [max(0, initArea(1)-0.5) max(0, initArea(2)-0.5)];
        endArea = [min(10, endArea(1)+0.5) min(10, endArea(2)+0.5)];
    end
    rectangle('Position', [initArea(1) initArea(2) endArea(1)-initArea(1) endArea(2)-initArea(2)]);
end

close all
clear all
clc

axis('square')
set(gca, 'XLim', [0 10], 'YLim', [0 10])
hold on

%TODO: refactoring from rectangle to obstacle

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta, rectanglesColor] = getInitialConfig("config_files/random.txt");
[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);

[currentPosition, initArea, destination, donePath, toDoPath, finishPlot] = initVariables();

[pathToDestination, graphMatrix, nodePositions] = findPath(currentPosition, destination, initArea, rectanglesPosition);
[currentPositionPlot, graphPlot] = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, [], graphMatrix, nodePositions, []);
pause(2); % Wait in order to evaluate the field

while not(currentPosition == destination)
    tic % Starting piece of code time count
    [currentPosition, pathToDestination, initArea] = updateCurrentPosition(currentPosition, pathToDestination, initArea);
    [rectanglesPosition, rectanglesDirection, rectanglesDelta] = calculateNewObstaclesPosition(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta);
    
    if not(isPathAvailable(pathToDestination, rectanglesPosition))
        [pathToDestination, graphMatrix, nodePositions] = findPath(currentPosition, destination, initArea, rectanglesPosition);
    end
    [currentPositionPlot, graphPlot] = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, currentPositionPlot, graphMatrix, nodePositions, graphPlot);
    calculateWaitTimeAndWait();
end
delete(finishPlot);
plot(10, 10, 'Marker','s', 'MarkerEdgeColor','blue', 'MarkerSize', 30, 'LineWidth',2); %Finish


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


function [currentPositionPlot, graphPlot] = draw(currentPosition, toDoPath, donePath, pathToDestination, rectanglesPosition, rectanglesColor, currentPositionPlot, graphMatrix, nodePositions, graphPlot)
    clearpoints(toDoPath);
    placeObstacles(rectanglesPosition, rectanglesColor);
    addpoints(donePath, currentPosition(1), currentPosition(2));
    addpoints(toDoPath, pathToDestination(:, 1), pathToDestination(:,2));
    if not(isempty(currentPositionPlot))
        delete(currentPositionPlot)
    end
    if(not(isempty(graphPlot)))
        delete(graphPlot)
    end
    currentPositionPlot = plot(currentPosition(1), currentPosition(2), 'Marker','o', 'MarkerSize',10, 'MarkerEdgeColor', 'blue' ,'MarkerFaceColor','b');
    graphPlot = plot(graph(graphMatrix), 'XData', nodePositions(:, 1), 'YData', nodePositions(:, 2), 'EdgeColor','#EAEAEA', 'MarkerSize', 0.1);
    graphPlot.NodeLabel = {};
end


function [rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = addFountainToObstacles(rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta)
    rectanglesPosition = cat(1, rectanglesPosition, [4 4 2 2]);
    rectanglesMovementEnabled = cat(1, rectanglesMovementEnabled, 0);
    rectanglesDirection = cat(1, rectanglesDirection, 0);
    rectanglesDelta = cat(1, rectanglesDelta, 0);
end

function [currentPosition, initArea, destination, donePath, toDoPath, finishPlot] = initVariables()
    currentPosition = [0 0];
    initArea = currentPosition;
    destination = [10 10];
    donePath = animatedline('Color','b', 'LineWidth',3);
    toDoPath = animatedline('Color','r','LineWidth',3);
    plot(0, 0, 'Marker','s', 'MarkerEdgeColor','blue', 'MarkerSize',30, 'LineWidth',2); %Start
    finishPlot = plot(10, 10, 'Marker','s', 'MarkerEdgeColor','red', 'MarkerSize', 30, 'LineWidth',2); %Finish
end

function [remainingWaitTime] = calculateWaitTimeAndWait()
    toc
    remainingWaitTime = 1 - toc;
    if remainingWaitTime > 0
        pause(remainingWaitTime);
    end
end


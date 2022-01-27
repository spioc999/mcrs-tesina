function [path] = findPath(from, to, initArea, obstacles)
    % setup

    totalArea = (10 - initArea(1)) * (10 - initArea(2)); %Number of total points depends on area
    maxTrials = round(totalArea * 5);

    placedPoints = [];
    pointsRoles = [];

    for i=1:maxTrials
        newPointX = initArea(1) + (10 - initArea(1)).*rand; % random number in given area
        newPointY = initArea(2) + (10 - initArea(2)).*rand; % random number in given area
        newPoint = [newPointX newPointY];
        if isFreePoint(newPoint, obstacles, true)
            numSeenGuards = lookForGuards(newPoint, placedPoints, pointsRoles, obstacles);
            if numSeenGuards == 0
                placedPoints = cat(1, placedPoints, newPoint);
                pointsRoles = cat(1, pointsRoles, Role.GUARD);
            elseif numSeenGuards >= 2
                placedPoints = cat(1, placedPoints, newPoint);
                pointsRoles = cat(1, pointsRoles, Role.CONNECTOR);
            end
        end
    end

    % Adding from & to to the list of placed points
    placedPoints = cat(1, placedPoints, from, to);
    pointsRoles = cat(1, pointsRoles, Role.START, Role.END);


    numberOfPlacedPoints = size(placedPoints, 1)
    adjacencyMatrix = zeros(numberOfPlacedPoints, numberOfPlacedPoints);
    for i=1:numberOfPlacedPoints
        for j=i+1:numberOfPlacedPoints
            if isFreeEdge(placedPoints(i, :), placedPoints(j,:), obstacles, [], true) && not(pointsRoles(i) == pointsRoles(j))
                distance = norm(placedPoints(i, :) - placedPoints(j, :));
                adjacencyMatrix(i, j) = distance;
                adjacencyMatrix(j, i) = distance;
            end
        end
    end

    fromNodeIndex = size(placedPoints, 1) - 1;
    toNodeIndex = size(placedPoints, 1);
    adjacencyMatrixGraph = graph(adjacencyMatrix);
    shortestPath = [];
    unattainableNodes = [];
    while not(isempty(toNodeIndex)) && isempty(shortestPath)
        shortestPath = adjacencyMatrixGraph.shortestpath(fromNodeIndex, toNodeIndex);
        if isempty(shortestPath)
            currentToNode = placedPoints(toNodeIndex, :);
            unattainableNodes = cat(1, unattainableNodes, toNodeIndex);
            toNodeIndex = findNearestNode(currentToNode, placedPoints, unattainableNodes);
        end
    end
    if not(isempty(toNodeIndex)) % If path to destination not found then don't move
        path = placedPoints(shortestPath, :);
    else
        path = from;
    end

end

function [nearestNodeIndex] = findNearestNode(currentToNode, allNodes, unattainableNodes)
    nearestDist = 20;
    nearestNodeIndex = [];
    for i=1:size(allNodes, 1)
        if not(any(unattainableNodes(:) == i)) % Perform only nodes not in unattainableNodes array
            currentDist = norm(currentToNode - allNodes(i, :));
            if(currentDist < nearestDist)
                nearestDist = currentDist;
                nearestNodeIndex = i;
            end
        end
    end
end

function [numSeenGuards] = lookForGuards(newPoint, placedPoints, pointsRoles, obstacles)
    numSeenGuards=0;
    for i=1:size(placedPoints, 1)
       if pointsRoles(i) == Role.GUARD && isFreeEdge(newPoint, placedPoints(i,:), obstacles)
            numSeenGuards = numSeenGuards + 1;
        end
    end
end











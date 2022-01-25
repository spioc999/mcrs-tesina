function [isAvailable] = isPathAvailable(path, obstacles)
    isAvailable = true;
    for i=1:size(path, 1)-1
        if not(isFreeEdge(path(i,:), path(i+1,:), obstacles, [], true))
            isAvailable = false;
            break
        end
    end
end
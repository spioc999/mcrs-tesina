function [] = placeObstacles(rectangles)
    rect = findall(gcf,'Type', 'Rectangle'); 
    delete(rect)
    rectangle('Position',[0 0 10 10]); % Field

    rectangle('Position',[0.5 2 1 2]); 
    rectangle('Position',[1 8 3 1]);
    rectangle('Position',[7 1 1.5 1.5]);
    rectangle('Position',[7 8 2 1.5]);
    rectangle('Position',[1 5 1.5 1.5]);
    rectangle('Position',[2 1 4 2]);
    rectangle('Position',[7.5 4.5 2 3]);
    rectangle('Position',[4 4 2 2], 'Curvature',1, 'FaceColor','#4487d4'); %% Blocked area
end
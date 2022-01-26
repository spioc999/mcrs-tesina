function [] = placeObstacles(rectangles, colors)
    rect = findall(gcf,'Type', 'Rectangle'); 
    delete(rect)
    initField();
    for i=1:size(rectangles, 1)
        if not(isequal(rectangles(i, :), [4 4 2 2]))
            rectangle('Position',[rectangles(i, 1) rectangles(i, 2) rectangles(i, 3) rectangles(i, 4)], 'FaceColor', colors(i, :)); 
        end
    end
end

function [] = initField()
    rectangle('Position',[0 0 10 10]); % Field
    %% Fountain
    rectangle('Position',[4 4 2 2], 'FaceColor','#606b7d');
    rectangle('Position',[4.125 4.125 1.75 1.75], 'Curvature',1, 'FaceColor','#4487d4');
    rectangle('Position',[4.75 4.75 0.5 0.5], 'Curvature', 1, 'FaceColor','#606b7d');
end
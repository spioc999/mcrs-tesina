function [isColliding, xColliding, yColliding] = checkCollisionWithFountain(x, y, w, h)

isColliding = false;
xColliding = 0;
yColliding = 0;

%left edge
if not(edgeNotInFountain([x, y], [x, y+h]))
    isColliding = true;
    xColliding = x - 6;
end

%top edge
if not(edgeNotInFountain([x, y+h], [x+w, y+h]))
    isColliding = true;
    yColliding = y - 4;
end

%right edge
if not(edgeNotInFountain([x+w, y+h], [x+w, y]))
    isColliding = true;
    xColliding = x - 4;
end

%bottom edge
if not(edgeNotInFountain([x+w, y], [x, y]))
    isColliding = true;
    yColliding = y - 6;
end

end

function [isEdgeNotInFountain] = edgeNotInFountain(startPoint, endPoint)

alpha = 0:0.02:1;
i = 1;
exitCondition = false;
isEdgeNotInFountain = true;

while(not(exitCondition))
    x = alpha(i)*startPoint(1) + (1-alpha(i))*endPoint(1);
    y = alpha(i)*startPoint(2) + (1-alpha(i))*endPoint(2);

    isEdgeNotInFountain = isFreePoint([x y], [4, 4, 2, 2]); %Fountain

    exitCondition = i >= length(alpha) || not(isEdgeNotInFountain);

    i = i+1;
end    

    
end
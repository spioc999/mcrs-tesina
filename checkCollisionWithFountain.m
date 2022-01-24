function [isColliding] = checkCollisionWithFountain(x, y, w, h)

isColliding = false;

%left edge
if not(edgeNotInFountain([x, y], [x, y+h])) 
    isColliding = true;
%right edge
elseif not(edgeNotInFountain([x+w, y+h], [x+w, y]))
    isColliding = true;
%top edge
elseif not(edgeNotInFountain([x, y+h], [x+w, y+h]))
    isColliding = true;
%bottom edge
elseif not(edgeNotInFountain([x+w, y], [x, y]))
    isColliding = true;
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
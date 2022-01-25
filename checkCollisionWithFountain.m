function [isColliding] = checkCollisionWithFountain(x, y, w, h)

isColliding = false;
fountain = [4 4 2 2];

%left edge
if not(isFreeEdge([x, y], [x, y+h], fountain)) 
    isColliding = true;
%right edge
elseif not(isFreeEdge([x+w, y+h], [x+w, y], fountain))
    isColliding = true;
%top edge
elseif not(isFreeEdge([x, y+h], [x+w, y+h], fountain))
    isColliding = true;
%bottom edge
elseif not(isFreeEdge([x+w, y], [x, y], fountain))
    isColliding = true;
end

end
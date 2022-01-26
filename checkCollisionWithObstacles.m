function [isColliding] = checkCollisionWithObstacles(x, y, w, h, obstacles)

isColliding = false;
for i=1:size(obstacles, 1)
    isColliding = isCollidingBlock1Block2([x y w h], obstacles(i, :)) || isCollidingBlock1Block2(obstacles(i, :), [x y w h]);
    if isColliding
        break
    end
end

end

function [isColliding] = isCollidingBlock1Block2(block1, block2)
    isColliding = false;
    if (((block1(1) > block2(1) && block1(1) < block2(1) + block2(3)) || ...
            (block1(1)+block1(3) > block2(1) && block1(1)+block1(3) < block2(1) + block2(3))) && ...
            ((block1(2) > block2(2) && block1(2) < block2(2) + block2(4)) || ...
            (block1(2)+block1(4) > block2(2) && block1(2)+block1(4) < block2(2) + block2(4)))) || ...
            (block1(1) < block2(1) && block1(1)+block1(3) > block2(1) + block2(3) && ...
            block1(2) > block2(2) && block1(2) + block1(4) < block2(2) + block2(4))
        isColliding = true;
    end
end





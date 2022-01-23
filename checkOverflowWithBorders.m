function [isOverflow, xOverflow, yOverflow] = checkOverflowWithBorders(limit, x, y, w, h)

isOverflow = false;
xOverflow = 0;
yOverflow = 0;

if x < 0
    isOverflow = true;
    xOverflow = x;
end

if y < 0
    isOverflow = true;
    yOverflow = y;
end

if x + w > limit
    isOverflow = true;
    xOverflow = x + w - limit;
end

if y + h > limit
    isOverflow = true;
    yOverflow = y + h - limit;
end

end
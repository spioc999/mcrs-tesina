function [isOverflow, xOverflow, yOverflow] = checkOverflowWithBorders(x, y, w, h)

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

if x + w > 10
    isOverflow = true;
    xOverflow = x + w - 10;
end

if y + h > 10
    isOverflow = true;
    yOverflow = y + h - 10;
end

end
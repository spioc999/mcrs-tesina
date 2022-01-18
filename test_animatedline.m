close all
clear all
clc

x = 0:0.1:1;

set(gca, 'XLim', [0 1.25], 'YLim', [0 1.25])

a = animatedline;

for i=1:length(x)
    addpoints(a, x(i), x(i));
    drawnow
    pause(0.3)
end

for i=1:length(x)
    [x, y] = getpoints(a);
    clearpoints(a);
    addpoints(a, x(1:end-1), y(1:end-1));
    drawnow
    pause(0.3)
end
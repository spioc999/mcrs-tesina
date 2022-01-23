close all
clear all
clc
limit = 10;
axis('square')
set(gca, 'XLim', [0 limit], 'YLim', [0 limit])

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/random.txt");

placeObstacles(rectanglesPosition);

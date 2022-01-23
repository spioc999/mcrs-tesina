close all
clear all
clc
axis('square');
set(gca, 'XLim', [0 10], 'YLim', [0 10]);

[rectanglesPosition, rectanglesMovementEnabled, rectanglesDirection, rectanglesDelta] = getInitialConfig("config_files/random.txt");

placeObstacles(rectanglesPosition);

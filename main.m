close all
clear all
clc

limit = 10;
axis('square')
set(gca, 'XLim', [0 limit], 'YLim', [0 limit])

placeObstacles();
clc;
clear all;

%this is a matlab-based slot machine game

%initialise constants
SPRITE_HEIGHT = 100;
SPRITE_WIDTH = 100;
ROWS = 3;
COLS = 3;

money = 1000;
bet = 5;
reels = 5;

%initialise GUI
rootFigure = figure('Name', 'Slot Machine Game', 'NumberTitle', 'off', 'Position', [100, 100, 700, 250]);

imageDisplay = imshow(255*ones(SPRITE_HEIGHT*2, SPRITE_WIDTH*reels, 3, 'uint8'));

moneyLable = text(5, 225, sprintf('Balance: $%i', money), 'FontSize', 12, 'Color', 'black');
betLable = text(5, 245, sprintf('Bet: $%i', bet), 'FontSize', 12, 'Color', 'black');


spinButton = uicontrol('Style', 'pushbutton', 'String', 'Spin', 'BackgroundColor', [0.2, 0.6, 0.2], 'ForegroundColor', 'white', 'Position', [160, 15, 150, 30]);
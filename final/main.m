% ======================================================================
% Filename: main.m
% Stage: done
% Version: v2
% Date: 28/4/25
% 
% CHANGES IN THIS VERSION:
% - seperate gui initialization from other functions
% - improved modularity 
%
% TESTING DONE:
% - visial iterations and comparisons made by displaying GUI in a figure
% ======================================================================


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

reels = input("How many reels do you want to play? ");

%initialise GUI
rootFigure = figure('Name', 'Slot Machine Game', 'NumberTitle', 'off', 'Position', [100, 100, 700, 250]);

imageDisplay = imshow(255*ones(SPRITE_HEIGHT*2, SPRITE_WIDTH*reels, 3, 'uint8'));

moneyLable = text(5, 225, sprintf('Balance: $%i', money), 'FontSize', 12, 'Color', 'black');
betLable = text(5, 245, sprintf('Bet: $%i', bet), 'FontSize', 12, 'Color', 'black');

betInputBox = uicontrol('Style', 'edit', 'Position', [150, 15, 40, 30], 'FontSize', 12, 'String', num2str(bet),'BackgroundColor', [0.6, 0.6, 0.0]);
betButton = uicontrol('Style', 'pushbutton', 'String', 'Change Bet', 'Position', [190, 15, 70, 30], ...
    'FontSize', 10, 'Callback', @(src, event) changeBet(betInputBox, betLable),'BackgroundColor', [0.6, 0.6, 0.0]);

%when clicked, the spin button calls spinButtonCallback(...), which
%continues code exectution
spinButton = uicontrol('Style', 'pushbutton', 'String', 'Spin', 'BackgroundColor', [0.2, 0.6, 0.2], 'ForegroundColor', 'white', 'Position', [260, 15, 50, 30], ...
    'Callback', @(src, event) spinButtonCallback(src, event, imageDisplay, rootFigure, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, reels, moneyLable,betLable,betButton,betInputBox));
clc;
clear all;

SPRITE_HEIGHT = 100;
SPRITE_WIDTH = 100;

ROWS = 3;
COLS = 3;
REELS = 5;

money = 1000;
bet = 5;

FIG = figure('Name', 'Slot Machine Game', 'NumberTitle', 'off', 'Position', [100, 100, 400, 250]);

img = imshow(zeros(SPRITE_HEIGHT, SPRITE_WIDTH*REELS, 3, 'uint8'));

% Labels for money and bet
moneyLable = text(5, 125, sprintf('Balance: $%i', money), 'FontSize', 12, 'Color', 'black');
betLable = text(5, 145, sprintf('Bet: $%i', bet), 'FontSize', 12, 'Color', 'black');

% Button to spin the reels
btn = uicontrol('Style', 'pushbutton', 'String', 'Spin', 'BackgroundColor', [0.2, 0.6, 0.2], 'ForegroundColor', 'white', 'Position', [260, 15, 50, 30], ...
    'Callback', @(src, event) spinAndUpdate(src, event, img, FIG, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS, moneyLable,betLable));

% Input box for changing the bet amount
betInputBox = uicontrol('Style', 'edit', 'Position', [150, 15, 40, 30], 'FontSize', 12, 'String', num2str(bet),'BackgroundColor', [0.6, 0.6, 0.0]);

% Button to confirm the new bet amount
betButton = uicontrol('Style', 'pushbutton', 'String', 'Change Bet', 'Position', [190, 15, 70, 30], ...
    'FontSize', 10, 'Callback', @(src, event) changeBet(betInputBox, betLable),'BackgroundColor', [0.6, 0.6, 0.0]);

% Callback function to update bet amount
function changeBet(betInputBox, betLable)
    % Get the new bet amount from the input box
    newBet = str2double(get(betInputBox, 'String'));
    
    % Check if the new bet is a valid number and update bet
    if ~isnan(newBet) && newBet > 0
        bet = newBet;  % Update the bet value
        betLable.String = sprintf('Bet: $%i', bet);  % Update the bet label
    else
        msgbox('Please enter a valid bet amount!', 'Invalid Input', 'error');
    end
end

% Callback function for spinning and updating the balance
function spinAndUpdate(src, event, img, FIG, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS, moneyLable,betLable)
    
    bet = str2double(betLable.String(7:end));
    money = str2double(moneyLable.String(11:end)) - bet;
    moneyLable.String = sprintf('Balance: $%i', money);
    
    set(src, 'Enable', 'off');
    set(FIG, 'Name', 'Spinning...', 'NumberTitle', 'off');
    
    [multi, text] = spin(img, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS);
    
    set(FIG, 'Name', text, 'NumberTitle', 'off');
    
    money = money + bet * multi;
    moneyLable.String = sprintf('Balance: $%i', money);
    
    set(src, 'Enable', 'on');
end

% spin function 
function [returnMulti, text] = spin(hImg, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS)
    TOTAL_SPRITES = ROWS * COLS;
    SPRITESHEET = imread('spritesheet.jpg');
    sprites = cell(ROWS, COLS);
    
    for r = 1:ROWS
        for c = 1:COLS
            sprites{r, c} = SPRITESHEET(...
                (r-1)*SPRITE_HEIGHT + 1 : r*SPRITE_HEIGHT, ...
                (c-1)*SPRITE_WIDTH + 1 : c*SPRITE_WIDTH, ...
                :);
        end
    end

    flatSprites = reshape(sprites, [], 1);
    reelIdx = zeros(1, REELS);
    reels = cell(1, REELS);

    stopDelays = linspace(0.5, 2.5, REELS);
    startTime = tic;
    spinning = true(1, REELS);

    while any(spinning)
        elapsed = toc(startTime);
    
        for i = 1:REELS
            if spinning(i)
                idx = randi(TOTAL_SPRITES);
                reelIdx(i) = idx;
                reels{i} = flatSprites{idx};
                if elapsed >= stopDelays(i)
                    spinning(i) = false;
                end
            end
        end
    
        % Update image
        combined = cat(2, reels{:});
        set(hImg, 'CData', combined);
        drawnow;
        pause(0.05);
    end

    maxStreakStart = 1;
    maxStreakLength = 1;
    currStreak = 1;

    for i = 2:REELS
        if reelIdx(i) == reelIdx(i-1)
            currStreak = currStreak + 1;
            if currStreak > maxStreakLength
                maxStreakLength = currStreak;
                maxStreakStart = i - currStreak + 1;
            end
        else
            currStreak = 1;
        end
    end

    if maxStreakLength >= 2
        blinkFrames = maxStreakLength * 5 - 1;
        for b = 1:blinkFrames
            show = mod(b, 2) == 1;
        
            blinkReels = reels;
            if ~show
                for i = maxStreakStart:(maxStreakStart + maxStreakLength - 1)
                    blinkReels{i} = 255*ones(SPRITE_HEIGHT, SPRITE_WIDTH, 3, 'uint8');
                end
            end
        
            set(hImg, 'CData', cat(2, blinkReels{:}));
            drawnow;
            pause(0.2);
        end
    end
    
    % determine win or loss and multiplier
    switch maxStreakLength
        case 1
            returnMulti = 0;
            text = "You lose";
        case 2
            returnMulti = 1;
            text = "Return";
        case 3
            returnMulti = 2;
            text = "2x win!";
        case 4
            returnMulti = 10;
            text = "10x win";
        case 5
            returnMulti = 100;
            text = "100x win";
    end
end

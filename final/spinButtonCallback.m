
% ======================================================================
% Filename: spinButtonCallback.m
% Stage: done
% Version: v2
% Date: 28/4/25
% 
% CHANGES IN THIS VERSION:
% - update lables
% - seperate from main function
% - calculate money/bet amount
% TESTING DONE:
% - visual testing done through figure GUI
% ======================================================================



function spinButtonCallback(src, event, img, FIG, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS, moneyLable, betLable,betButton,betInputBox)
    %turn buttons off
    set(betButton, 'Visible','off');
    set(betInputBox, 'Visible','off');
    
    %withold bet amount
    bet = str2double(betLable.String(7:end));
    money = str2double(moneyLable.String(11:end)) - bet;
    moneyLable.String = sprintf('Balance: $%i', money);

    
    set(src, 'Enable', 'off');
    set(FIG, 'Name', 'Spinning...', 'NumberTitle', 'off');
    pause(0.5);

    %spin animation
    [multi, text] = spin(img, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS);

    set(FIG, 'Name', text, 'NumberTitle', 'off');
    %update balance
    money = money + bet * multi;
    moneyLable.String = sprintf('Balance: $%i', money);

    pause(0.5);
    
    %reset
    set(src, 'Enable', 'on');
    set(betButton, 'Visible','on');
    set(betInputBox, 'Visible','on');
end
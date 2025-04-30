
% ======================================================================
% Filename: spin.m
% Stage: done
% Version: v3
% Date: 28/4/25
% 
% CHANGES IN THIS VERSION:
% - seperate from main function
% - implement wildcards and bonus spins
% TESTING DONE:
% - visual testing done through figure GUI
% - driverfiles used for win-case algorithms
% ======================================================================


function [returnMulti, text] = spin(hImg, SPRITE_HEIGHT, SPRITE_WIDTH, ROWS, COLS, REELS)
    %get sprites from spritesheet
    [sprites, TOTAL_SPRITES] = createSpritesVector('spritesheet.jpg', ROWS, COLS, SPRITE_HEIGHT, SPRITE_WIDTH);

    WILD_IDX = 5; %id of BAR symbol
    BONUS_IDX = 3; %id of 7 symbol

    reelIdx = zeros(1, REELS);%internal IDS to keep track of reels

    stopDelays = linspace(1.5, 3.5, REELS); % spin times
    startTime = tic;
    spinning = true(1, REELS);

    VISIBLE_HEIGHT = round(SPRITE_HEIGHT * 2);
    combined = zeros(VISIBLE_HEIGHT, SPRITE_WIDTH * REELS, 3, 'uint8');

    spinSpeed = linspace(0.01, 0.15, 50); % gradually slow down

    spinCounter = 1;

    while any(spinning)
        elapsed = toc(startTime);
        
        %spin reels randomly 
        for i = 1:REELS
            if spinning(i)
                centerIdx = randi(TOTAL_SPRITES);
                reelIdx(i) = centerIdx;
            
                %calculate sprites above and below
                topIdx = mod(centerIdx - 2, TOTAL_SPRITES) + 1;
                bottomIdx = mod(centerIdx, TOTAL_SPRITES) + 1;
            
                topSprite = sprites{topIdx};
                centerSprite = sprites{centerIdx};
                bottomSprite = sprites{bottomIdx};
                
                %combine column and cut top and bottom half-sprites
                stacked = cat(1, topSprite, centerSprite, bottomSprite);
                startY = round(SPRITE_HEIGHT / 2);
                visible = stacked(startY:(startY + VISIBLE_HEIGHT - 1), :, :);

                xStart = (i-1) * SPRITE_WIDTH + 1;
                xEnd = xStart + SPRITE_WIDTH - 1;
                combined(:, xStart:xEnd, :) = visible;
                    
                %stop spinning reel if its past its spinning time
                if elapsed >= stopDelays(i)
                    spinning(i) = false;
                end
            end
        end
        
        %render and delay next spin slightly
        set(hImg, 'CData', combined);
        drawnow;
        pause(spinSpeed(min(spinCounter, end)));
        spinCounter = spinCounter + 1;
    end
    
    %determine if there are any x-in-a-row streaks (including wilds)
    [streakLength, startIndex] =  getSequentialMatchesInArray(reelIdx, WILD_IDX);
    
    %determine if a bonus roll is needed (3 total bonus sprites)
    bonusCount = sum(reelIdx == BONUS_IDX);
    
    %blink columns if they are in a streak
    if streakLength >= 2
        blinkFrames = streakLength * 5 - 1;
        if mod(blinkFrames, 2) == 0
            blinkFrames = blinkFrames + 1;
        end

        for b = 1:blinkFrames
            show = mod(b, 2) == 1;

            blinkCombined = combined;

            if ~show
                for i = startIndex:(startIndex + streakLength - 1)
                    xStart = (i - 1) * SPRITE_WIDTH + 1;
                    xEnd = xStart + SPRITE_WIDTH - 1;
                    blinkCombined(:, xStart:xEnd, :) = 255;
                end
            end

            set(hImg, 'CData', blinkCombined);
            drawnow;
            pause(0.2);
        end

        % play win sound
        try
            sound(sin(1:300));
        catch
            % no sound support
        end
    end

    % bonus round trigger
    if bonusCount >= 3
        text = "BONUS ROUND!";
        returnMulti = 50; % big bonus
        bonusRoundAnimation(hImg, combined); %flashing animation
        return;
    end

    %determine payouts
    switch streakLength
        case 1
            returnMulti = 0;
            text = "You lose";
        case 2
            returnMulti = 1;
            text = "Return";
        case 3
            returnMulti = 4;
            text = "4x win!";
        case 4
            returnMulti = 20;
            text = "20x win!";
        otherwise 5
            returnMulti = 100;
            text = "100x JACKPOT!!";
    end
end



function bonusRoundAnimation(hImg, combined)
    for i = 1:11
        temp = combined;
        if mod(i, 2) == 0
            temp = 255 - temp;%invert colours
        end
        set(hImg, 'CData', temp);
        drawnow;
        pause(0.15);
    end
end

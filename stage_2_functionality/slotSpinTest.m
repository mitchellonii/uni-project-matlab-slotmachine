% ======================================================================
% Filename: slotSpinTest.m
% Stage: experimentation
% Version: v1
% Date: 24/4/25
% 
% CHANGES IN THIS VERSION:
% - initial version
%
% TESTING DONE:
% - testing done via figure-output-inspection
% ======================================================================


spritesheet = imread('spritesheet.jpg'); 

spriteHeight = 100;
spriteWidth = 100;

rows = 3;
cols = 3;
totalSprites = 9;

sprites = cell(rows, cols);
for r = 1:rows
    for c = 1:cols
        sprites{r, c} = spritesheet(...
            (r-1)*spriteHeight + 1 : r*spriteHeight, ...
            (c-1)*spriteWidth + 1 : c*spriteWidth, ...
            :);
    end
end

% Flatten into 1D list
flatSprites = reshape(sprites, [], 1);

% Number of reels (columns)
numReels = 5;

% Initialize reels with random sprites
reels = cell(1, numReels);
for i = 1:numReels
    reels{i} = flatSprites{randi(totalSprites)};
end

% Setup figure
hFig = figure;
hImg = imshow(cat(2, reels{:}));
title('Spinning...');

% Reel stop delays
stopDelays = linspace(0.5, 2.5, numReels); % Staggered stop times
startTime = tic;

spinning = true(1, numReels); % Reels still spinning

while any(spinning)
    elapsed = toc(startTime);
    
    for i = 1:numReels
        if spinning(i)
            reels{i} = flatSprites{randi(totalSprites)};
            if elapsed >= stopDelays(i)
                spinning(i) = false; % Stop this reel
            end
        end
    end
    
    % Update the display
    combined = cat(2, reels{:});
    set(hImg, 'CData', combined);
    drawnow;
    
    pause(0.05); % Control spin speed
end

title('Result!');

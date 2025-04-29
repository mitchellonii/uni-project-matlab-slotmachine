% test driver for getSequentialMatchesInArray

clear; clc;


reelSpin = randi(9,1,7)%1-9, 1x7
WILD_IDX = 3; % wild is 3

% display input array
disp('reel spin:');
disp(reelSpin);

% call the function
[streakLength, startIndex] = getSequentialMatchesInArray(reelSpin, WILD_IDX);

% display results
fprintf('longest streak length: %d\n', streakLength);
fprintf('streak starting at index: %d\n', startIndex);

% optional: highlight the matched streak
disp('matched streak symbols:');
disp(reelSpin(startIndex:startIndex+streakLength-1));

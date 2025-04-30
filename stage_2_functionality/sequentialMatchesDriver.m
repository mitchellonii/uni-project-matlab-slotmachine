% ======================================================================
% Filename: sequentialMatchesDriver.m
% Stage: finalizing
% Version: v2
% Date: 24/4/25
% 
% CHANGES IN THIS VERSION:
% - updated for new version of getSequentialMatchesInArray.m
% - tests for 'wildcards' in a array element streak
%
% TESTING DONE:
% - driverfile is for testing and comparison
% ======================================================================
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

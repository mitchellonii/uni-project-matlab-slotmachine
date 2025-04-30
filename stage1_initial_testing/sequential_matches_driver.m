% ======================================================================
% Filename: sequential_matches_driver.m
% Stage: experimenting
% Version: v1
% Date: 20/4/25
% 
% CHANGES IN THIS VERSION:
% - n\a - initial version
%
% TESTING DONE:
% - all outputs displayed in console for visual comparision
% ======================================================================

clear; clc;


reelSpin = randi(9,1,7)%1-9, 1x7

% display input array
disp('reel spin:');
disp(reelSpin);

% call the function
[streakLength, startIndex] = getSequentialMatchesInArray(reelSpin);

% display results
fprintf('longest streak length: %d\n', streakLength);
fprintf('streak starting at index: %d\n', startIndex);

% optional: highlight the matched streak
disp('matched streak symbols:');
disp(reelSpin(startIndex:startIndex+streakLength-1));

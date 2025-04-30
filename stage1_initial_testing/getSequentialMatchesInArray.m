% ======================================================================
% Filename: getSequentialMatchesInArray.m
% Stage: experimenting
% Version: v1
% Date: 20/4/25
% 
% CHANGES IN THIS VERSION:
% - n\a - initial version
%
% TESTING DONE:
% - driver file made and run (see sequential_matches_driver.m)
% ======================================================================

function [streakLength, startIndex] = getSequentialMatchesInArray(array)
    % initialise temp variables
    n = length(array);
    if n == 0
        streakLength = 0;
        startIndex = 0;
        return;
    end

    streakLength = 1;
    bestStreak = 1;
    startIndex = 1;
    tempStart = 1;

    % loop through the array
    for i = 2:n
        if array(i) == array(i-1)
            streakLength = streakLength + 1;
        else
            streakLength = 1;
            tempStart = i;
        end

        % update best streak if needed
        if streakLength > bestStreak
            bestStreak = streakLength;
            startIndex = tempStart;
        end
    end

    % final output
    streakLength = bestStreak;
end

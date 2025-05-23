% ======================================================================
% Filename: getSequentialMatchesInArray.m
% Stage: done
% Version: v2
% Date: 24/4/25
% 
% CHANGES IN THIS VERSION:
% - Implements a WILD_IDX (wild id) to allow a wildcard sprite in the game
% - the streak will continue if it hits a wildcard
%
% TESTING DONE:
% - output displayed as a figure for verification
% ======================================================================


function [streakLength, startIndex] = getSequentialMatchesInArray(array, WILD_IDX)
    % initialise temp variables
    n = length(array);
    streakLength = 1;
    bestStreak = 1;
    startIndex = 1;
    tempStart = 1;
    baseSymbol = -1; % base symbol not set yet

    % loop through the array
    for i = 1:n
        symbol = array(i);

        % if base symbol not set yet
        if baseSymbol == -1
            if symbol ~= WILD_IDX
                baseSymbol = symbol; % set base symbol if not a wild
            end
            continue; % move to next symbol
        end

        % check if current symbol matches base or is wild
        if symbol == baseSymbol || symbol == WILD_IDX
            streakLength = streakLength + 1; % continue streak
        else
            if symbol == WILD_IDX
                streakLength = streakLength + 1; % wild extends streak
            else
                baseSymbol = symbol; % reset base symbol
                streakLength = 1; % reset streak
                tempStart = i; % new streak start
            end
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

% ======================================================================
% Filename: changeBet.m
% Stage: done
% Version: v1
% Date: 28/4/25
% 
% CHANGES IN THIS VERSION:
% - initial version
%
% TESTING DONE:
% - see gui_expected_interactions.txt
% ======================================================================


function changeBet(betInputBox, betLable)
    % get the new bet amount from the input box
    newBet = str2double(get(betInputBox, 'String'));
    
    % check if the new bet is a valid number and update bet
    if ~isnan(newBet) && newBet > 0
        bet = newBet;  % update the bet value
        betLable.String = sprintf('Bet: $%i', bet);  % update the bet label
    else
        msgbox('Please enter a valid bet amount!', 'Invalid Input', 'error');
    end
end

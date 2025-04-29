% test driver for getSequentialMatchesInArray

clear; clc;


reelSpin = randi(9,1,12);%1-9, 1x12
BONUS_IDX = 3; % bonus is 3

% display input array
disp('reel spin:');
disp(reelSpin);

% call the function
amountOf7s = sum(reelSpin == BONUS_IDX); %sum of all elements in ReelSpin where the condition "reelSpin(n) == BONUS_IDX" is met for all n

bonus = false;
if amountOf7s >=3
    bonus = true;
end
% display results
fprintf('amount of bonus cards: %d\n', amountOf7s);
fprintf('bonus spin triggered: %d\n', bonus);

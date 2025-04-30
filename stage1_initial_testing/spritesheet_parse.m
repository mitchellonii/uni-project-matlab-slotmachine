% ======================================================================
% Filename: spritesheet_parse.m
% Stage: experimenting
% Version: v1
% Date: 20/4/25
% 
% CHANGES IN THIS VERSION:
% - n\a - initial version
%
% TESTING DONE:
% - output displayed as a figure for verification
% ======================================================================
spritesheet = imread('spritesheet.jpg'); 

%height and width of indevidual sprites to crop on the sheet
spriteHeight = 100;
spriteWidth = 100;

%rows and cols on the spritesheet to crop
rows = 3;
cols = 3;


figure;


for idx = 1:(rows * cols)
    %determine local row and col 
    row = floor((idx-1) / 3);
    col = mod((idx-1), 3);
    %'crop' section and display
    sprite = spritesheet(...
        (row*spriteHeight + 1):(row+1)*spriteHeight, ...% the '...' syntax allows code to carry-over on a newline
        (col*spriteWidth + 1):(col+1)*spriteWidth, ...
        :);
    
    imshow(sprite);
    title(['Sprite ', num2str(idx)]);
    
    pause(0.5); 
end

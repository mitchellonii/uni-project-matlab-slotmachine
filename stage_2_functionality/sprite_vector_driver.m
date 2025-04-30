% ======================================================================
% Filename: sprite_vector_driver.m
% Stage: done
% Version: v1
% Date: 24/4/25
% 
% CHANGES IN THIS VERSION:
% - initial version
% TESTING DONE:
% - driverFile for createSpriteVector.m
% - checks dimensions match and tests amount of sprites match
% ======================================================================

clc;
clear all;

sprites = createSpritesVector("spritesheet.jpg", 3, 3, 100, 100);


expectedLength = 9;
expectedSpriteHeightWidth = 100;


for i=1:length(sprites)
    if size(sprites{i}) == [expectedSpriteHeightWidth expectedSpriteHeightWidth 3];% 3 because rgb = 3 channels
        fprintf("Sprite %i matched expected dimensions (expected %ix%i, found %ix%i)\n", i,expectedSpriteHeightWidth, expectedSpriteHeightWidth, width(sprites{i}),height(sprites{i}));
    else
        fprintf("Sprite %i failed against expected dimensions (expected %ix%i, found %ix%i)\n", i,expectedSpriteHeightWidth, expectedSpriteHeightWidth, width(sprites{i}),height(sprites{i}));
    end
end

if length(sprites) == expectedLength
    fprintf("Sprite vector length matched expected of %i (%i)", expectedLength, length(sprites))
else
    fprintf("Sprite vector length failed against expected of %i (%i)", expectedLength, length(sprites))
end

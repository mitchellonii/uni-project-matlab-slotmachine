function [flatSprites,TOTAL_SPRITES] = createSpritesVector(fileName, ROWS, COLS, SPRITE_HEIGHT, SPRITE_WIDTH)

    TOTAL_SPRITES = ROWS * COLS;
    SPRITESHEET = imread(fileName);
    sprites = cell(ROWS, COLS);
     
    %'crop' spritesheet into a x by x vector of sprites
    for r = 1:ROWS
        for c = 1:COLS
            sprites{r, c} = SPRITESHEET(...
                (r-1)*SPRITE_HEIGHT + 1 : r*SPRITE_HEIGHT, ...
                (c-1)*SPRITE_WIDTH + 1 : c*SPRITE_WIDTH, ...
                :);
        end
    end

    flatSprites = reshape(sprites, [], 1);
end
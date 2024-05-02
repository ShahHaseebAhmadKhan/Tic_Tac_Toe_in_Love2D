-- This function is called by the Love2D framework to configure the game.
function love.conf(t)
    -- Set the title of the game window to 'Tic'.
    t.window.title = 'Tic'
    
    -- Set the width of the game window to 600 pixels.
    t.window.width = 600
    
    -- Set the height of the game window to 600 pixels.
    t.window.height = 600
    
    -- Set the level of multi-sample anti-aliasing (MSAA) to 4 samples per pixel.
    t.window.msaa = 4
end

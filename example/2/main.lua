require("animFULL")

function love.load()

    player = animatedSprFromFile('player.spr', 10, 10) -- load a .spr file

    -- [[ this file was exported from a previusly made sprite using saveAnimsToFile() ]] --

    player:setCurAnim('idle') 
    
    -- [[ even if i didnt create the anim with newAnim() this still works cuz it exists in the player.spr file ]] -- 

end 

function love.update(dt)   

    player:update()

end     

function love.draw()

    love.graphics.setBackgroundColor(0, 0.05, 0.3)
    player:draw()

end
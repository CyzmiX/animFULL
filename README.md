# AnimFULL

## What is AnimFULL?

AnimFULL is a sprite sheet support library made for the amaziing love2D game framework, it's simple, fast, and easy to use!

## Example Code

(this example is the 1st exemple wich is available to download in the example folder!)

```lua
require('animFULL')


function love.load()

    playerMoving = false --variable to know if the player is moving

    spr = animatedSpr('player.png', 10, 10) --creating a sptitsheet object


    spr:newAnim('idle', 0, 0, 32, 32, 2, 0.1, true) --storing animation inside it

    spr:newAnim('run', 0, 32*3, 32, 32, 8, 0.2, true)

    spr:setCurAnim('idle') --setting the begin anim to idle

end 

function love.update(dt)
     -- Change the Animation based off of the playerMoving variable --
    if playerMoving then 
        spr:setCurAnim('run')
    else
        spr:setCurAnim('idle')
    end

    -- Making the player move setting playerMove to true so that we can chage the animation to run -- 
    if love.keyboard.isDown('a') then 
        spr.x = spr.x - 2   
        playerMoving = true 

    elseif love.keyboard.isDown('d') then 
        spr.x = spr.x + 2
        playerMoving = true      
    elseif love.keyboard.isDown('w') then 
        spr.y = spr.y - 2 
        playerMoving = true 

    elseif love.keyboard.isDown('s') then 
        spr.y = spr.y + 2 
        playerMoving = true
    else 
        playerMoving = false 
    end 

    spr:update() -- updating the sprite
end 


function love.draw()

    love.graphics.setBackgroundColor(0, .01, .1)

    spr:draw() -- drawing the sprite
end
```

## Documentation

Docs can be found over the doc folder

# Sprite Sheet

## THIS WIKI DOES NOT COVER EVERYTHING AS ITS STILL A WIP!

## Creation

a sprite object is used to store varius animations, so lets create on!

```lua
spr = animatedSpr('sprite sheet path', x, y)
```

parameters are pretty self explanatory (the x and y are were the sprite will be drawn)

## Adding Animation

now that we have a sprSheet object lets some anims to it!

we will do that with the newAnim() function like so 

```lua
spr:newAnim('tag', x, y, width, height, number of frames, speed a small number like 0.1, should it loop)
```

the tag is gonna be later used to make this animation as the current one so remenber it! x and y are the position of the first frame in your animation, so for example this sprite has an idle anim on the first row so the position of the first frame is 0, 0, width and height are the dimensions of the frames in the case of our sprite its 32, 32, number of frames is well ... the number of frames lol, and speed and loop are self explanatory (make sure loop is a boolean true or false!)

## Setting the current animation

to set the currently displayed animation use setCurAnim()

```lua
spr:setCurAnim(tag of the animation)
```

## Updating the sprite

__THIS IS NEEDED IN ORDER FOR THE ANIMATION TO PLAY!!__

just put spr:update() in love.update()

```lua
function love.update()
    spr:update()
end
```

## Drawing the sprite

you draw your sprite with draw()

```lua
function love.draw()
    spr:draw()
end
```

## Creating a save file for sprites DOES NOT WORK ON MOBILE!

(Check the 2nd example in the example forlder for more detail)

Lets say you built a spriteSheet object and added all the animations to it, if you wanna reuse the same spriteSheet you dont have to rewrite the hole code you can export it as a .spr file that can be read by AnimFULL

```lua
function love.load()
    spr:saveAnimsToFile('file name without extension!')
end
```

Then on another project just use __animatedSprFromFile()__

```lua
function love.load()
    newSpr = animatedSprFromFile('spr.spr', x, y)
end
```

for the x and y they are the same as in __animatedSpr()__

## More Functions

a list of function that are kinda usefull

| Function               | What it does                                                                                                |
|:----------------------:|:-----------------------------------------------------------------------------------------------------------:|
| deleteAnim('anim tag') | deletes the passed anim, duh                                                                                |
| printAllAnim()         | prints a list of all anim attached to a sprSheet object (needs terminal to be enabled)                      |
| getCurAnim()           | return the tag of the current animation                                                                     |
| curAnimHasFinished()   | returns true if the current animation has finished (if its a looped animation this will never return true!) |

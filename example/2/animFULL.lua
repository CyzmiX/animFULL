--[[

    Stuff to make my life easier

]]--
local lg = love.graphics

local indexs = {
    img = 1,
    tag = 2,
    x = 3,
    y = 4,
    width = 5,
    height = 6,
    frameCount = 7,
    speed = 8,
    loop = 9
}

--[[ Helper Class For Animations ]]--
local function Animation(tag, img, x, y, width, height, frameCount, speed, loop)
    return {
        tag = tag, 
        x = x, 
        y = y, 
        width = width,
        height = height,
        frameCount = frameCount,
        curFrame = 1,
        speed = speed or 0.1, 
        loop = loop or false,
        img = img,
        finished = false,
        frames = {},
        
        
        getQuads = function(self) -- used in love.load to get all quads once in the program life for better performance 
            
            for i = 0, self.frameCount do  
                table.insert(self.frames, lg.newQuad(self.x + (self.width*i), self.y, self.width, self.height, self.img))
            end

        end,

        hasFinished = function(self)

            return self.finished

        end,

        play = function(self)

            self.curFrame = self.curFrame + self.speed

            if math.floor(self.curFrame) >= #self.frames then 
                if self.loop then 
                    self.curFrame = 1 
                else 
                    self.curFrame = #self.frames - 1
                    self.finished = true 
                end 
            end 

        end  


    }

end 

--[[ Interface Class ]]--
function animatedSpr(img, x, y)

    return {
        imgName = img,
        img = lg.newImage(img),
        x = x,
        y = y, 
        
        anims = {},
        curAnim = nil, 
        scale = {1,1},
    
        setCurAnim = function(self, tag)
            
            for _, anim in ipairs(self.anims) do 
                if anim.tag == tag then 
                    self.curAnim = anim
                    
                end
               
            end
    
        end, 

        printAllAnims = function( self )
            
            for k, anim in ipairs(self.anims) do
                print(k .. " - " ..anim.tag) 
            end

        end, 

        getCurAnim = function( self )
            
            return self.curAnim.tag 
        
        end,
        
        setScale = function(self, sx, sy)
            
            self.scale = {sx, sy}
        
        end,

        deleteAnim = function(self, tag)
            
            for k, anim in ipairs(self.anims) do 
                if anim.tag == tag then 
                    anim.frames = {} -- free thequads for better preformance
                    table.remove(self.anims, k) -- then delete the anim from the anims list
                else 
                    assert(false, "No animation with the tag " .. tag .. " exists!")
                end 
            end 

        end,                

        newAnim = function(self, tag, x, y, width, height, frameCount, speed, loop)

            for _, anim in ipairs(self.anims) do 
                if anim.tag == tag then 
                    assert(false, "An animation with the tag " .. tag .. " already exists")
                end 
            end 

            local a = Animation(tag, self.img, x, y, width, height, frameCount, speed, loop)
            a:getQuads() -- create all quads once for better performance
            table.insert(self.anims, a) -- append the anim to the anims list

        end,
        
        draw = function( self )

            lg.draw(self.img, self.curAnim.frames[math.floor(self.curAnim.curFrame)], self.x, self.y, nil, self.scale[1], self.scale[2])
        
        end,

        resetCurAnim = function( self )
            self.curAnim.finished = false
            self.curAnim.curFrame = 1
        end,
        
        update = function( self )

            self.curAnim:play() -- play the anim
        
        end,

        curAnimHasFinished = function( self )

            return self.curAnim.finished
  
        end,

        moveBy = function(self, x, y)

            assert(type(x) == 'number', "You must pass a number to moveBy() not a " .. type(x))
            assert(type(y) == 'number', "You must pass a number to moveBy() not a " .. type(y))
            self.x = self.x + x 
            self.y = self.y + y 
        
        end,

        moveTo = function(self, x, y)

            assert(type(x) == 'number', "You must pass a number to moveBy() not a " .. type(x))
            assert(type(y) == 'number', "You must pass a number to moveBy() not a " .. type(y))
            self.x = x 
            self.y = y 
        
        end,

        saveAnimsToFile = function(self, fileName)

            local f = io.open(fileName .. ".spr", 'a')
            f:write(self.imgName..'\n---\n')
            for k, anim in ipairs(self.anims) do 
                if k == #self.anims then 
                    f:write(anim.tag .. "\n" .. anim.x .. "\n" .. anim.y .. "\n" .. anim.width .. "\n".. anim.height .. "\n" .. anim.frameCount .. "\n" .. anim.speed .. "\n" .. tostring(anim.loop) .. "\n")
                else
                    f:write(anim.tag .. "\n" .. anim.x .. "\n" .. anim.y .. "\n" .. anim.width .. "\n".. anim.height .. "\n" .. anim.frameCount .. "\n" .. anim.speed .. "\n" .. tostring(anim.loop) .. "\n---\n")

                end
            end
            f:close()

        end

            
    }
end 

function animatedSprFromFile(file, x, y)

    local f = io.open(file, 'r')
    local l = {}
    for line in io.lines(file) do 
        l[#l + 1] = line 
    end 

    s = animatedSpr(l[indexs.img], x, y)

    for k, line in ipairs(l) do
        if line == "---" then
            local bool = false
            if l[k+8] == "true" then 
                bool = true 
            end
            s:newAnim(
                l[k+1], 
                tonumber(l[k+2]),
                tonumber(l[k+3]),
                tonumber(l[k+4]),
                tonumber(l[k+5]),
                tonumber(l[k+6]),
                tonumber(l[k+7]),
                bool
            )
        end 
    end 


    return s



end 
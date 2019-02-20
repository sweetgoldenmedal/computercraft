--[[
 The turltle should be placed outside the region to be copied facing the lowest z/x corner

 * * * * * * * * * *
 *                 *
 *                 *
 *                 *
 *                 *
 *                 *
 *                 *
 *                 *
 *                 *
 * * * * * * * * * *
 x

]]--

DEBUG = false
os.loadAPI("lib/inventory.lua")
os.loadAPI("lib/movement.lua")

local args = {...}

areaWidth   = args[1] or 10
areaDepth   = args[2] or 10
areaHeight  = args[3] or 10

if(#args ~= 3) then
    print("Usage:\n"..((shell and shell.getRunningProgram()) or "copyRegion.lua").." <width> <depth> <height>") error()
end

starting_xpos, xpos = 0,0
starting_zpos, zpos = -1,-1 -- we start one block outside the area
starting_ypos, ypos = 0,0
xdir = 0
zdir = 1

-- local movement translation
function printLocation()
    print("xpos: "..xpos.." zpos: "..zpos.." ypos: "..ypos.." xdir: "..xdir.." zdir: "..zdir)
end
function moveForward()
    xpos,zpos,ypos,xdir,zdir = movement.moveForward(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end
function moveBackward()
    xpos,zpos,ypos,xdir,zdir = movement.moveBackward(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end
function turnLeft()
    xpos,zpos,ypos,xdir,zdir = movement.turnLeft(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end
function turnRight()
    xpos,zpos,ypos,xdir,zdir = movement.turnRight(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end
function moveUp()
    xpos,zpos,ypos,xdir,zdir = movement.moveUp(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end
function moveDown()
    xpos,zpos,ypos,xdir,zdir = movement.moveDown(xpos,zpos,ypos,xdir,zdir)
    printLocation()
end


-- copy logic
function copyColumn()
    for n=1,areaDepth+1 do
        if(turtle.detect()) then
            -- there's a block
            local return_value , blockdata = turtle.inspect()
            if(return_value == true) then
                print("Copy this shit: "..blockdata.name)
            end 
        end
        turtle.dig()
        moveForward()
    end
end

  
copyColumn()



    -- copy the block type in front of turtle
    -- break block in front of the turtle
    -- move forward 1 
    -- if zpos > 1, replace the block behind
    -- if zpos == areaDepth
        -- return
        -- if xpos < areaWidth 
            -- move to next column
        -- else 
            -- return to starting corner



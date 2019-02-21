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

function copyColumn()

	blockAhead
	blockOccupied
	blockBehind
		
    for n=1,areaDepth+1 do
		-- check the block ahead
        if(turtle.detect()) then
            local returnValue , blockData = turtle.inspect()
            if(returnValue == true) then
				blockAhead = blockData.name
				-- if we find a block, store the block type and position
            end 
        end

		-- destroy the block ahead and move forward
        turtle.dig()
        moveForward()

		-- turn around and replace the blockBehind if we are 2 or more blocks into the column
		if(n>2) then
			turtle.turnRight()
			turtle.turnRight()
			turtle.place(inventory.findBlockByExactName(blockBehind))
			turtle.turnRight()
			turtle.turnRight()
		end

		-- shuffle variables
		blockBehind = blockOccupied
		blockOccupied = blockAhead
    end
end

  
copyColumn()


-- copy blockAhead to 

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



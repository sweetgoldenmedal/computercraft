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
os.loadAPI("lib/inventory")
os.loadAPI("lib/movement")

local args = {...}

fileName	= args[1]
areaWidth   = args[2] 
areaDepth   = args[3] 
areaHeight  = args[4]

if(#args ~= 4) then
    print("Usage:\n"..((shell and shell.getRunningProgram()) or "copyRegion.lua").." <name> <width> <depth> <height>") error()
end

fileHandle = io.open(fileName,"a")
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

		-- shuffle variables "backwards", freeing up blockAhead to store the next block value
		blockBehind = blockOccupied
		blockOccupied = blockAhead

		-- store the data about the blockoccupied
		fileHandle:write(xpos,zpos,ypos,xdir,zdir,blockOccupied,'\n')
    end
end

  
copyColumn()
-- close the tracking file
io.close(fileHandle)



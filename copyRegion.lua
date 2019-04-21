--[[
 The turtle should be placed outside the region to be copied facing the lowest z/x corner

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

fileName    = args[1]
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

    blockAhead          = ''
    blockAheadMeta      = ''

    blockOccupied       = ''
    blockOccupiedMeta   = ''

    blockBehind         = ''
    blockBehindMeta     = ''

    for n=1,areaDepth+1 do
		-- check the block ahead
        if(turtle.detect()) then
            local returnValue , blockData = turtle.inspect()
            if(returnValue == true) then
				blockAhead      = blockData.name
                blockAheadMeta  = blockData.metadata
            end 
        end

		-- destroy the block ahead and move forward
        turtle.dig()
        moveForward()

		-- shuffle variables "backwards", freeing up blockAhead and blockAheadMeta to store the next block value
		blockBehind         = blockOccupied
		blockBehindMeta     = blockOccupiedMeta

		blockOccupied       = blockAhead
		blockOccupiedMeta   = blockAheadMeta

		-- turn around and replace the blockBehind if we are 1 or more blocks into the column
		if(n>1) then
			turtle.turnRight()
			turtle.turnRight()
			turtle.place(turtle.select(inventory.findBlockByNameAndMeta(blockBehind,blockBehindMeta)))
			turtle.turnRight()
			turtle.turnRight()
		end

		-- store the data about the blockoccupied
		fileHandle:write(xpos..','..zpos..','..ypos..','..xdir..','..zdir..','..blockOccupied..','..blockOccupiedMeta..'\n')
    end
end

for w=1,areaWidth do  
    copyColumn()
    if(zdir == 1) then
        turnRight()
        moveForward()
        turnRight()
    else
        turnLeft()
        moveForward()
        turnLeft()
    end
end

-- close the tracking file
io.close(fileHandle)



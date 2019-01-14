-- TODO: grass (and presumably any other obstruction keeps the block from being interacted with
-- TODO: mobs getting in the way will no doubt foul things up also
DEBUG = false 
-- load up the libraries
--os.loadAPI("lib/movement")
os.loadAPI("lib/inventory")

starting_xpos, xpos = 0,0
starting_zpos, zpos = 0,0
starting_ypos, ypos = 0,0
xdir = 0
zdir = 1


function moveUp()
    if DEBUG then textutils.slowPrint("function: moveUp()") end
    ypos = ypos + 1
    if(turtle.up()) then
        return true
    else
        return false
    end
end

function moveDown()
    if DEBUG then textutils.slowPrint("function: moveUp()") end
    ypos = ypos - 1
    if(turtle.down()) then
        return true
    else
        return false
    end
end

function moveBack()
    if DEBUG then textutils.slowPrint("function: moveBack()") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.back()) then
        return true
    else
        return false
    end
end

function moveForward()
    if DEBUG then textutils.slowPrint("function: moveForward()") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.forward()) then
        return true
    else
        return false
    end
end

function turn_left()
    if DEBUG then textutils.slowPrint("function: turn_left()") end
    xdir, zdir = -zdir, xdir
    if(turtle.turnLeft()) then
        return true
    else
        return false
    end
end

function turn_right()
    if DEBUG then textutils.slowPrint("function: turn_right()") end
    xdir, zdir = zdir, -xdir
    if(turtle.turnRight()) then
        return true
    else
        return false
    end
end

function colReturn() -- return to the beginning of the column
    if DEBUG then textutils.slowPrint("function: colReturn()") end
    while(zdir ~= -1) do
        turn_right()
    end
    while zpos > starting_zpos do
        if not (moveForward()) then 
            textutils.slowPrint("unable to move foward, returning false")
            return false
        end        
    end
end

function rowReturn()
    if DEBUG then textutils.slowPrint("function: rowReturn()") end
    while(xdir ~= -1) do
        turn_right()
    end
    while(xpos > starting_xpos) do
        moveForward()
    end
end

function moveToNextCol() -- pathways are 3 blocks apart
    if DEBUG then textutils.slowPrint("function: moveToNextCol()") end
    while(xdir ~= 1) do
        turn_left()
    end
    for n=1,3 do
        if not moveForward() then
            return false
        end
    end
    return true
end

function moveToNextBlock()  -- move z+1 and turn to face the new block
    if DEBUG then textutils.slowPrint("function: moveToNextBlock()") end
    while(zdir ~= 1) do
        turn_left()
    end
    if not moveForward() then -- if we are blocked from moving toward positive z, return false
        return false
    end
    turn_right()
    return true
end

function checkBlock() -- conditionally harvest or plant the block
    if DEBUG then textutils.slowPrint("function: checkBlock()") end
    if(turtle.detect()) then
        if DEBUG then textutils.slowPrint("turtle.detect() found something") end
        local return_value , blockdata = turtle.inspect()
        if(return_value == true) then
            --print("Block name: ", blockdata.name)
            --print("Block metadata: ", blockdata.metadata)
            -- if the block in front is a fence (of any kind) it is time to turn
            if(string.match(blockdata.name, "minecraft:wheat")) then
                if DEBUG then textutils.slowPrint("I found wheat, now checking age") end
                if (string.match(blockdata.metadata, 7)) then
                    if DEBUG then textutils.slowPrint("The wheat is age 7, harvesting") end
                    harvestBlock()
                else 
                    if DEBUG then textutils.slowPrint("The wheat is not age 7, skipping...") end
                end
            end
        end
    else
        if DEBUG then textutils.slowPrint("turtle.detect() didn't find anything, planting now...") end
        plantBlock()
    end 
    return true 
end

function harvestBlock() -- largely redundant function (could just use plantBlock()), but it makes the logic more understandable I think
    if DEBUG then textutils.slowPrint("function: harvestBlock()") end
    turtle.dig() -- harvest the existing wheat
    plantBlock()
end

function plantBlock()
    if DEBUG then textutils.slowPrint("function: plantBlock()") end
    turtle.dig()
    turtle.select(inventory.findBlockByNameMatch("seed"))
    turtle.place()
end

function harvestColumn()
    if DEBUG then textutils.slowPrint("function: harvestColumn()") end
    while(moveToNextBlock()) do
        checkBlock()
    end
    return true
end

function moveUpOneLevel()
    for n=1,4 do
        if not (moveUp()) then
           moveDownToGroundLevel() 
        end
    end
end

function moveDownToGroundLevel()
    while(ypos ~= 0) do
        if not (moveDown()) then
            return false
        end
    end
end

while(inventory.findBlockByNameMatch("seeds")) do
    if(harvestColumn()) then
        colReturn()
        if not (moveToNextCol()) then
            rowReturn() 
            moveUpOneLevel()
        end
    end
end

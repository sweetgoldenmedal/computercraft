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
rowSpacing = 2


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
    if DEBUG then textutils.slowPrint("function: moveDown()") end
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
    for n=1,rowSpacing do
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
            return false
        end
    end
    return true
end

function moveDownToGroundLevel()
    while(ypos > starting_ypos) do
        if not (moveDown()) then
            return false
        end
    end
    return true
end

function dumpWheat()
    while(zdir ~= -1) do -- face toward -z so you're facing the chest that sits at the corner of the garden
        turn_left()
    end
    while(inventory.findBlockByExactName("minecraft:wheat")) do   
        turtle.select(inventory.findBlockByExactName("minecraft:wheat"))
        turtle.drop()
    end 
    return true
end

while(inventory.findBlockByNameMatch("seeds")) do   -- remove seeds from the turtle inventory as a means of stopping it
    if(harvestColumn()) then                        -- attempt to harvest the current column 
        colReturn()                                 -- return to the start of the column upon completion
        if not (moveToNextCol()) then               -- attempt to move to the next column
            rowReturn()                             -- if you can't assume you are at the end of the row and attempt to return to the beginning of the row
            if not (moveUpOneLevel()) then          -- assume you have completed all rows on this level, ascend one level
                dumpWheat()                         -- make sure the top of the chests+hopper cascade is at the ceiling
                moveDownToGroundLevel()             -- if you can't ascend (you hit the ceiling) go back down
            end
        end
    end
end

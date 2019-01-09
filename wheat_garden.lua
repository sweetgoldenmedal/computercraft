DEBUG = 1
-- load up the libraries
--os.loadAPI("lib/movement")
os.loadAPI("lib/inventory")

starting_xpos, xpos = 0,0
starting_zpos, zpos = 0,0
xdir = 0
zdir = 1

function moveBack()
    if DEBUG then print("function: moveBack()") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.back()) then
        return true
    else
        return false
    end
end

function moveForward()
    if DEBUG then print("function: moveForward()") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.forward()) then
        return true
    else
        return false
    end
end

function turnLeft()
    if DEBUG then print("function: turnLeft()") end
    xdir = -zdir
    zdir = xdir
    if DEBUG then print("post turn values: xdir: "..xdir.." zdir: " ..zdir) end
    if(turtle.turnLeft()) then
        return true
    else
        return false
    end
end

function turnRight()
    if DEBUG then print("function: turnRight()") end
    xdir = zdir
    zdir = -xdir
    if DEBUG then print("post turn values xdir: "..xdir.." zdir: " ..zdir) end
    if(turtle.turnRight()) then
        return true
    else
        return false
    end
end

function colReturn() -- return to the beginning of the column
    if DEBUG then print("function: colReturn()") end
    while(zdir ~= -1) do
        turnRight()
    end
    while zpos > starting_zpos do
       moveForward()
    end
end

function rowReturn()
    if DEBUG then print("function: rowReturn()") end
    while(xdir ~= -1) do
        turnRight()
    end
    while(xpos > starting_xpos) do
        moveForward()
    end
end

function moveToNextCol() -- pathways are 3 blocks apart
    if DEBUG then print("function: moveToNextCol()") end
    while(xdir ~= 1) do
        turnLeft()
    end
    for n=1,3 do
        if not moveForward() then
            rowReturn()
        end
    end
end

function moveToNextBlock()  -- move z+1 and turn to face the new block
    if DEBUG then print("function: moveToNextBlock()") end
    while(zdir ~= 1) do
        turnLeft()
    end
    if not moveForward() then -- if we are blocked from moving toward positive z, return false
        return false
    end
    turnRight()
    return true
end

function checkBlock() -- conditionally harvest or plant the block
    if DEBUG then print("function: checkBlock()") end
    if(turtle.detect()) then
        if DEBUG then print("turtle.detect() found something") end
        local return_value , blockdata = turtle.inspect()
        if(return_value == true) then
            --print("Block name: ", blockdata.name)
            --print("Block metadata: ", blockdata.metadata)
            -- if the block in front is a fence (of any kind) it is time to turn
            if(string.match(blockdata.name, "minecraft:wheat")) then
                if DEBUG then print("I found wheat, now checking age") end
                if (string.match(blockdata.metadata, 7)) then
                    if DEBUG then print("The wheat is age 7, harvesting") end
                    harvestBlock()
                else 
                    if DEBUG then print("The wheat is not age 7, skipping...") end
                end
            end
        end
    else
        if DEBUG then print("turtle.detect() didn't find anything, planting now...") end
        plantBlock()
    end 
end

function harvestBlock() -- largely redundant function (could just use plantBlock()), but it makes the logic more understandable I think
    if DEBUG then print("function: harvestBlock()") end
    turtle.dig() -- harvest the existing wheat
    plantBlock()
end

function plantBlock()
    if DEBUG then print("function: plantBlock()") end
    turtle.dig()
    inventory.findBlockByNameMatch("wheat")
    turtle.place()
end

function harvestColumn()
    if DEBUG then print("function: harvestColumn()") end
    while(moveToNextBlock()) do
        checkBlock()
    end
    colReturn()
end

--while(inventory.findBlockByNameMatch("seeds")) do
--    harvestColumn()
--    moveToNextCol()
--end
harvestColumn()
--moveToNextCol()

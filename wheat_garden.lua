DEBUG = 1
-- load up the libraries
--os.loadAPI("lib/movement")
os.loadAPI("lib/inventory")

starting_xpos, xpos = 0,0
starting_zpos, zpos = 0,0
xdir = 0
zdir = 1

function moveBack()
    if DEBUG then print("executing moveBack function") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.back()
    return true
end

function moveForward()
    if DEBUG then print("executing moveForward function") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.forward()
    return true
end

function turnLeft()
    if DEBUG then print("executing turnLeft function") end
    xdir = -zdir
    zdir = xdir
    turtle.turnLeft()
    return true
end

function turnRight()
    if DEBUG then print("executing turnRight function") end
    xdir = zdir
    zdir = -xdir
    turtle.turnRight()
    return true
end

local function colReturn() -- return to the beginning of the column and attempt to move to the next column
    if DEBUG then print("function: colReturn()") end
    while(zdir ~= -1) do
        turnRight()
    end
    while zpos > starting_zpos do
        moveForward()
    end
    moveToNextCol()
end

local function rowReturn()
    if DEBUG then print("function: rowReturn()") end
    while(xdir ~= -1) do
        turnRight()
    end
    while(xpos > starting_xpos) do
        moveForward()
    end
end

local function moveToNextCol() -- pathways are 3 blocks apart
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

local function moveToNextBlock()  -- move z+1 and turn to face the new block
    if DEBUG then print("function: moveToNextBlock()") end
    while(zdir ~= 1) do
        turnLeft()
    end
    if not moveForward() then -- if we are blocked from moving toward positive z, return to the beginning of the col
        colReturn()
    end
    turnRight()
end

local function checkBlock() -- conditionally harvest or plant the block
    if DEBUG then print("function: checkBlock()") end
    if(turtle.detect()) then
        local return_value , blockdata = turtle.inspect()
        if(return_value == true) then
            --print("Block name: ", blockdata.name)
            --print("Block metadata: ", blockdata.metadata)
            -- if the block in front is a fence (of any kind) it is time to turn
            if(string.match(blockdata.name, "minecraft:wheat") and string.match(blockdata.metadata, 7)) then
                harvestBlock()
            end
        else
            plantBlock()
        end
    end
end

local function harvestBlock() -- largely redundant function (could just use plantBlock()), but it makes the logic more understandable I think
    if DEBUG then print("function: harvestBlock()") end
    turtle.dig() -- harvest the existing wheat
    plantBlock()
end

local function plantBlock()
    if DEBUG then print("function: plantBlock()") end
    turtle.dig()
    inventory.findBlockByNameMatch("wheat")
    turtle.place()
end

local function harvestColumn()
    if DEBUG then print("function: harvestColumn()") end
    moveToNextBlock()
    checkBlock()
end

--while(inventory.findBlockByNameMatch("seeds")) do
--    harvestColumn()
--    moveToNextCol()
--end
harvestColumn()
print("sleeping for 10 seconds")
sleep(10)
moveToNextCol()
print("sleeping for 10 seconds")
sleep(10)
harvestColumn()
print("sleeping for 10 seconds")
sleep(10)
moveToNextCol()

-- load up the libraries
os.loadAPI("lib/movement")
os.loadAPI("lib/inventory")

starting_xpos, xpos = 0,0
starting_zpos, zpos = 0,0
xdir = 0
zdir = 1

local function colReturn() -- return to the beginning of the column and attempt to move to the next column
    while(zdir ~= -1) do
        movement.turnRight()
    end
    while zpos > starting_zpos do
        movement.moveForward()
    end
    moveToNextCol()
end

local function rowReturn()
    while(xdir ~= -1) do
        movement.turnRight()
    end
    while(xpos > starting_xpos) do
        movement.moveForward()
    end
end

local function moveToNextCol() -- pathways are 3 blocks apart
    while(xdir ~= 1) do
        movement.turnLeft()
    end
    for n=1,3 do
        if not movement.moveForward() then
            rowReturn()
        end
    end
end

local function moveToNextBlock()  -- move z+1 and turn to face the new block
    while(zdir ~= 1) do
        movement.turnLeft()
    end
    if not movement.moveForward() then -- if we are blocked from moving toward positive z, return to the beginning of the col
        colReturn()
    end
    movement.turnRight()
end

local function checkBlock() -- conditionally harvest or plant the block
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
    turtle.dig() -- harvest the existing wheat
    plantBlock()
end

local function plantBlock()
    turtle.dig()
    inventory.findBlockByNameMatch("wheat")
    turtle.place()
end

local function harvestColumn()
    moveToNextBlock()
    checkBlock()
end

while(inventory.findBlockByNameMatch("seeds")) do
    harvestColumn()
    moveToNextCol()
end

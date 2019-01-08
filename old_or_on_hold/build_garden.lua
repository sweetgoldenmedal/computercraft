local DEBUG = true

-- argument processing
local args = {...}

if #args ~= 2 then
    print( "Usage: build_garden <garden_name> <side_length>" )
    print( "Note: turtle should face north when beginning to build" )
    return
end

local garden_name = args[1] or "default_garden"
local side_length = tonumber(args[2]) or 15

local xpos = 0
local ypos = 0
local facing_direction = 'n' 

if DEBUG then
	print("garden_name is: "..garden_name)
	print("side_length is: "..side_length)
end

-- this function should check the inventory to ensure there are enough raw materials to make a garden of the specified size
local function supply_check()
    --textutils.slowPrint("Calculating supplies needed to build a garden that is "..garden_width.." x "..garden_length.." in diameter")
end

function moveBack(moveCount)
	if DEBUG then print("executing moveBack function") end
	for n=1,moveCount do
		ypos = ypos - 1
		turtle.back()
	end
	return true
end

function moveForward(moveCount)
	if DEBUG then print("executing moveForward function") end
	for n=1,moveCount do
		ypos = ypos - 1
		print("n == "..n)
		turtle.forward()
	end
	return true
end

function turnLeft()
	if DEBUG then print("executing turnLeft function") end
	-- spatial tracking goes here
	turtle.turnLeft()
	return true
end

function turnRight()
	if DEBUG then print("executing turnRight function") end
		-- spatial tracking goes here
	turtle.turnRight()
	return true
end

function place_sign(gardenName)
	print("placing sign with name: "..gardenName)
	moveBack(2)
	turtle.select(findBlockByName("sign"))
	turtle.place(gardenName)
	turnRight()
	moveForward(1)
	turnLeft()
    moveForward(2)
	turnLeft()
	moveForward(1)
	turnRight()
end

-- build the fence to enclode garden_width x garden_height
function build_fence(side_length)
    -- get in position
	moveForward(1)
	turnLeft()
	turnLeft()
	generic_fence_loop(side_length)
	insideCorner()
	generic_fence_loop(side_length)
	insideCorner()
	generic_fence_loop(side_length)
	insideCorner()
	generic_fence_loop(side_length)
end

function generic_fence_loop(length)
	turtle.select(findBlockByName("fence"))
	turtle.place()
	for i=1,length-1 do
		moveBack(1)
		turtle.select(findBlockByName("fence"))
		turtle.place()
	end
end

function insideCorner()
	-- get inside for the final fence post
	turnRight()
	moveBack(1)
	turnLeft()
	moveForward(1)
	turnRight()
end

-- find block based on string argument
function findBlockByName(blockName)
	for n=1,16 do
		if turtle.getItemCount(n) ~= 0 then
			local itemDetails = turtle.getItemDetail(n) 
			if(string.match(itemDetails.name, blockName)) then
				return n
			end
		end
	end
	print("A block matching: "..blockName.." was not found")
	return 0
end


-- START

place_sign(garden_name)
build_fence( side_length )
print("done")



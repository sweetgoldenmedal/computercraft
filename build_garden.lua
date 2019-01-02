local DEBUG = true

-- argument processing
local args = {...}

if #args ~= 3 then
    print( "Usage: build_garden <garden_name> <garden_width> <garden_length>" )
    print( "Note: turtle should face north when beginning to build" )
    return
end

local garden_name = args[1] or "default_garden"
local garden_width = tonumber(args[2]) or 15
local garden_length = tonumber(args[3]) or 15

local xpos = 0
local ypos = 0
local facing_direction = 'n' 

if DEBUG then
	print("garden_name is: "..garden_name)
	print("garden_width is: "..garden_width)
	print("garden_length is: "..garden_length)
end

-- check to ensure that the garden size is viable
-- garden_width should be positive and greater than 3
-- garden_length must be positive and greater than 0
local function check_garden_dimensions ( width, length )
    if( width < 3 ) then
		print("Garden width must be greater than 3")
		return false
    end
    if ( length < 1 ) then
		print("Garden length must be greater than 1")
		return false
	end
    return true
end

-- this function should check the inventory to ensure there are enough raw materials to make a garden of the specified size
local function supply_check(garden_diameter)
    textutils.slowPrint("Calculating supplies needed to build a garden that is "..garden_width.." x "..garden_length.." in diameter")
end

function moveBack(moveCount)
	if DEBUG then print("executing moveBack function") end
	for n=1,moveCount do
		-- spatial tracking goes here
		turtle.back()
	end
	return true
end

function moveForward(moveCount)
	if DEBUG then print("executing moveForward function") end
	for n=1,moveCount do
		-- spatial tracking goes here
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
function build_left_fence(name, width, length)
    -- get in position
	moveForward(1)
	turnLeft()
	turnLeft()
	generic_fence_loop(length)
    build_corner()
end

function build_back_fence(length)
	-- get inside for the final fence post
	turnRight()
	moveBack(1)
    generic_fence_loop(length)
end

function generic_fence_loop(length)
	for i=1,length-1 do
		moveBack(1)
		turtle.select(findBlockByName("fence"))
		turtle.place()
	end
end

function build_corner ()
	turnRight()
	moveBack(1)
	turtle.select(findBlockByName("fence"))
	turtle.place()
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

print("checking garden dimensions:")
if not check_garden_dimensions( garden_width, garden_length ) then
	return
end

print("garden dimensions are acceptable")

place_sign(garden_name)
build_left_fence( garden_name, garden_width, garden_length )
build_back_fence( garden_width )
--build_right_fence( garden_name, garden_width, garden_length )
--build_front_fence( garden_name, garden_width, garden_length )



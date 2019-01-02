local DEBUG = true

-- argument processing
local args = {...}

if #args ~= 3 then
    print( "Usage: build_garden <garden_name> <garden_width> <garden_length>" )
    print( "Note: turtle should face north when beginning to build" )
    return
end

local garden_name = tonumber(args[1]) or 15
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
	if DEBUG then print("executing moveBack function")
	for n=0,moveCount do
		-- spatial tracking goes here
		turtle.back()
	end
	return true
end

function moveForward(moveCount)
	if DEBUG then print("executing moveForward function")
	for n=0,moveCount do
		-- spatial tracking goes here
		turtle.forward()
	end
	return true
end

function turnLeft()
	if DEBUG then print("executing turnLeft function")
	-- spatial tracking goes here
	turtle.turnLeft()
	return true
end

function turnRight()
	if DEBUG then print("executing turnRight function")
		-- spatial tracking goes here
	turtle.turnRight()
	return true
end

function place_sign(gardenName)
	print("placing sign with name: "..gardenName)
	moveBack(2)
	turtle.select(findBlockByName("sign"))
	turtle.place(gardenName)
	moveForward(2)
end

-- build the fence to enclode garden_width x garden_height
function build_left_fence(name, width, length)
	print("getting into start position")
	moveForward(2)
	turnLeft()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()


	print("beginning left side build loop")
	for i=1,length+1 do
		turtle.turnLeft()
		turtle.select(findBlockByName("fence"))
		turtle.place()			
		turtle.turnRight()
		turtle.forward()
	end
	turtle.back()
	turtle.back()
end

function build_back_fence(name,width,length)
	for i=1,length+1 do
		turtle.select(findBlockByName("fence"))
		turtle.place()			
		turtle.turnRight()
		turtle.forward()
		turtle.turnLeft()
	end
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
--build_back_fence( garden_name, garden_width, garden_length )
--build_right_fence( garden_name, garden_width, garden_length )
--build_front_fence( garden_name, garden_width, garden_length )




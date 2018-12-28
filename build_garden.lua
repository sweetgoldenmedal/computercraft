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

-- build the fence to enclode garden_width x garden_height
local function build_fence(name, width, length)
	-- two steps back, place a sign then get back to the starting point
	print("placing sign")
	turtle.back()
	turtle.back()
	turtle.select(findBlockByName("sign"))
	turtle.place(name)
	turtle.forward()
	turtle.forward()

	-- then a bunch of temporary hacky stuff to get us into position for building the fence from the right side
	print("getting into start position")
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnLeft()


	print("beginning first build loop")
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

build_fence( garden_name, garden_width, garden_length )




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

if DEBUG 
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
	-- two steps back, place a sign
	turtle.back()
	turtle.back()
	turtle.select(find_sign())
	turtle.place(name)

	-- two steps forward and start laying fence
	turtle.forward()
	turtle.forward()
	turtle.turnRight()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.turnLeft()
	for i=1,length+1 do
		turtle.select(find_block("fence"))
		turtle.place()			
		turtle.forward()
	end

	-- turn right
end

-- find a sign in your inventory
local function find_sign()
	for n=1,16 do
		local return_value , blockdata = turtle.getItemDetail(n) 
		if(string.match(blockdata.name, 'sign')) then                                                                                    
			return n
		end
	end	
end

-- find block based on string argument
local function find_block(block_name)
	for n=1,16 do
		if turtle.getItemCount(n) ~= 0 then
			if DEBUG print("there is something in slot: "..n.." getting detail now")
			local return_value , blockdata = turtle.getItemDetail(n) 
			if( string.match(blockdata.name, block_name) ) then
				return n
			end
		end
	end
	return false
end


-- START

print("checking garden dimensions:")
if not check_garden_dimensions( garden_width, garden_length ) then
	return
end

print("garden dimensions are acceptable")

print("checking for a fence block")
if find_block("fence") then
	print("we found a fence block")
else
	print("no fence block found")
end


print("checking for a sign block")
if find_block("sign") then
	print("we found a sign block")
else
	print("no fence sign found")
end


--build_fence( garden_name, garden_width, garden_length )




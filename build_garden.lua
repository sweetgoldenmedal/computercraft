-- argument processing
local args = {...}

if #args ~= 2 then
    print( "Usage: build_garden <garden_name> <garden_width> <garden_length>" )
    print( "Note: turtle should face north when beginning to build" )
    return
end

local garden_width = args[1] or 15
local garden_length = args[2] or 15

local xpos = 0
local ypos = 0
local facing_direction = 'n' 

-- check to ensure that the garden size is viable
-- garden_width should be positive and greater than 3
-- garden_length must be positive and greater than 0
local function check_garden_dimensions (garden_width, garden_length)
    if( garden_width < 3 ) then
		print("Garden width must be greater than 3")
		return false
    end
    if ( garden_length < 1 ) then
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
local function build_fence(garden_width, garden_length)
	-- two steps back, place a sign
	turtle.back()
	turtle.back()
	turtle.select(find_sign())
	turtle.place(garden_name)

	-- two steps forward and start laying fence
	turtle.forward()
	turtle.forward()
	for i=1,garden_length+1 do
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
		local return_value , blockdata = turtle.getItemDetail(n) 
		if(string.match(blockdata.name, block_name)) then                                                                                    
			return n
		end
	end
end


-- START

print("checking garden dimensions:")
if not check_garden_dimensions( garden_width, garden_length ) then
	return
end





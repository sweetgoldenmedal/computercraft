local args = {...}

if #args ~= 2 then
    print( "Usage: build_garden <width> <length> (note: width must be divisible by 3" )
    return
end

garden_width = args[1]
garden_length = args[2]

local function check_dimensions (garden_width, garden_length)
    if( garden_width % 3 ~= 0) then
            return false
    end
    return true
end

local function supply_check(garden_diameter)
    textutils.slowPrint("Calculating supplies needed to build a garden that is "..garden_diameter.." in diameter")
end


print("checking garden dimensions:")
if not check_dimensions(garden_width, garden_length) then
    print("garden width must by divisible by 3, please try again later")
    return
end



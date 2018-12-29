silent = false

local args = {...}

square_size = args[1] or 8

if #args < 1 then
    print("hey, you forgot to tell me how big of a square you want me to clear!!!")
    error()
end

textutils.slowPrint("I will clear a square that is "..square_size.." blocks on each side")

current_distance = 0
current_row = 1

while(current_row < square_size)
do
    -- dig a line forward
    while(current_distance < square_size)
    do
        turtle.dig()
        turtle.forward()
        current_distance = current_distance + 1
    end

    -- turn left and dig/move one block forward
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()

    while(current_distance > square_size)
    do
        turtle.dig()
        turtle.forward()
        current_distance = current_distance - 1
    end

    -- now turn right, and restart
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
end

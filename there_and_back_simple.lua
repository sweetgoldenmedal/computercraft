local args = {...}
target_distance = args[1] or 20

silent = false

if #args ~= 1
then
    print("Usage: "..shell.getRunningProgram().." distance_to_mine")
end

textutils.slowPrint("I will now mine "..target_distance.." blocks and then mine "..target_distance.." more blocks on the way back")

local current_distance = 0

-- outbound trip
while(current_distance < target_distance)
do
    turtle.dig()
    turtle.forward()
    current_distance = current_distance + 1
end

-- turn and move one block left
turtle.turnLeft()
turtle.dig()
turtle.forward()
turtle.turnLeft()

-- return trip
while(current_distance > 0)
do
    turtle.dig()
    turtle.forward()
    current_distance = current_distance - 1
end
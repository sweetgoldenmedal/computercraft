--while true do
os.loadAPI("refuel_module")

current_loop = 0
max_loops = 10

while(current_loop < max_loops)
do
    -- check for fuel
    if(turtle.getFuelLevel() < 100) then
        textutils.slowPrint("I am low on fuel, fueling up")
        refuel_module.refuel()
        textutils.slowPrint("Current fuel level is: "..turtle.getFuelLevel())
    end
    -- check to see what is in front of you
    if(turtle.detect()) then
        textutils.slowPrint("Something is in front of me")
        local return_value , blockdata = turtle.inspect()
        if(return_value == true) then
            --print("Block name: ", blockdata.name)
            --print("Block metadata: ", blockdata.metadata)
            -- if the block in front is a fence (of any kind) it is time to turn
            if(string.match(blockdata.name, 'fence')) then
                textutils.slowPrint("I have encountered a fence")
                textutils.slowPrint("I am turning right")
                turtle.turnRight()
            else -- otherwise, go forward
                turtle.forward()
            end

        end
    else
        textutils.slowPrint("Nothing is in front of me, I'm moving forward now")
        turtle.forward()
    end

    loop_count = loop_count+1
end

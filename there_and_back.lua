distance = args[0] or 20

if #args != 1
then
    print("Usage: "..shell.getRunningProgram().." distance_to_mine")
end

textutils.slowPrint("I will now mine "..distance.." blocks and then mine "..distance.." more blocks on the way back")
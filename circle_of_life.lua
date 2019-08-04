--DEBUG = false
--os.loadAPI("lib/inventory")
--os.loadAPI("lib/movement")

-- assume that the turtle will move around a square that is 22 on a side
-- assume that the parent turtle has completed the circuit minus one, e.g. the child
-- turtle is placed on the starting square (albeit facing the wrong direction)

function traverseSide(length)
    length = length or 22
    turtle.turnLeft()
    for i=1,length do 

        # ensure the parent turtle is reaped 
        turtle.dig() 

        turtle.forward()
    end
end

traverseSide()
traverseSide()
traverseSide()
# leave room to give birth
traverseSide(21)
# give birth 
turtle.place()
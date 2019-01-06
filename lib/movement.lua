function moveBack(moveCount)
    if DEBUG then print("executing moveBack function") end
    for n=1,moveCount do
        ypos = ypos - 1
        turtle.back()
    end
    return true
end

function moveForward(moveCount)
    if DEBUG then print("executing moveForward function") end
    for n=1,moveCount do
        ypos = ypos - 1
        print("n == "..n)
        turtle.forward()
    end
    return true
end

function turnLeft()
    if DEBUG then print("executing turnLeft function") end
    -- spatial tracking goes here
    turtle.turnLeft()
    return true
end

function turnRight()
    if DEBUG then print("executing turnRight function") end
    -- spatial tracking goes here
    turtle.turnRight()
    return true
end
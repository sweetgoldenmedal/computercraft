function moveBack()
    if DEBUG then print("executing moveBack function") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.back()
    return true
end

function moveForward()
    if DEBUG then print("executing moveForward function") end
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.forward()
    return true
end

function turnLeft()
    if DEBUG then print("executing turnLeft function") end
    xdir = -zdir
    zdir = xdir
    turtle.turnLeft()
    return true
end

function turnRight()
    if DEBUG then print("executing turnRight function") end
    xdir = zdir
    zdir = -xdir
    turtle.turnRight()
    return true
end

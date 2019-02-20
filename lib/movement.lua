function moveBack( xpos, zpos, ypos, xdir, zdir )
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.back()
    return xpos, zpos, ypos, xdir, zdir
end

function moveForward( xpos, zpos, ypos, xdir, zdir )
    xpos = xpos + xdir
    zpos = zpos + zdir
    turtle.forward()
    return xpos, zpos, ypos, xdir, zdir
end


function turnLeft( xpos, zpos, ypos, xdir, zdir )
    xdir = -zdir
    zdir = xdir
    turtle.turnLeft()
    return xpos, zpos, ypos, xdir, zdir
end

function turnRight( xpos, zpos, ypos, xdir, zdir )
    xdir = zdir
    zdir = -xdir
    turtle.turnRight()
    return xpos, zpos, ypos, xdir, zdir
end

function moveUp( xpos, zpos, ypos, xdir, zdir )
    ypos = ypos + 1
    if(turtle.up()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
end

function moveDown( xpos, zpos, ypos, xdir, zdir )
    ypos = ypos - 1
    if(turtle.down()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
end

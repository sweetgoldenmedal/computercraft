function moveBackward( xpos, zpos, ypos, xdir, zdir )
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.back()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
end

function moveForward( xpos, zpos, ypos, xdir, zdir )
    xpos = xpos + xdir
    zpos = zpos + zdir
    if(turtle.forward()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
end


function turnLeft( xpos, zpos, ypos, xdir, zdir )
    xdir = -zdir
    zdir = xdir
    if(turtle.turnLeft()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
end

function turnRight( xpos, zpos, ypos, xdir, zdir )
    xdir = zdir
    zdir = -xdir
    if(turtle.turnRight()) then
        return xpos, zpos, ypos, xdir, zdir
    else
        return false
    end
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

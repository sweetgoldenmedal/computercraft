DEBUG = false
os.loadAPI("lib/inventory.lua")
os.loadAPI("lib/movement.lua")

starting_xpos, xpos = 0,0
starting_zpos, zpos = 0,0
starting_ypos, ypos = 0,0
xdir = 0
zdir = 1

function moveForward()
        xpos,zpos,ypos,xdir,zdir = movement.moveForward(xpos,zpos,ypos,xdir,zdir)
end

print("xpos: "..xpos.." zpos: "..zpos.." ypos: "..ypos.." xdir: "..xdir.." zdir: "..zdir)
moveForward()
print("xpos: "..xpos.." zpos: "..zpos.." ypos: "..ypos.." xdir: "..xdir.." zdir: "..zdir)


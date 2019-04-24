DEBUG = true 
os.loadAPI("lib/inventory")
os.loadAPI("lib/movement")

local args = {...}

fileName    = args[1]

if(#args ~= 1) then
    print("Usage:\n"..((shell and shell.getRunningProgram()) or "pasteRegion.lua").." <name> ") error()
end

-- starting position
starting_xpos, xpos = 0,0
starting_zpos, zpos = -1,-1 -- we start one block outside the area
starting_ypos, ypos = 0,0
xdir = 0
zdir = 1

function goto(x, z, y, xd, zd) 
	if xPos > x then
		while xDir ~= -1 do
			turnLeft()
		end
		while xPos > x do
			if turtle.forward() then
				xPos = xPos - 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end
	elseif xPos < x then
		while xDir ~= 1 do
			turnLeft()
		end
		while xPos < x do
			if turtle.forward() then
				xPos = xPos + 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end
	end
end

for line in io.lines(fileName) do
	local xpos, zpos, ypos, xdir, zdir, blockName, blockMeta = line:match('(%d+),(%d+),(%d+),(%d+),(%d+),(.-),(%d+)')
	if DEBUG then 
		print("NEW LINE:")
		print("xpos: "..xpos)
		print("zpos: "..zpos)
		print("ypos: "..ypos)
		print("xdir: "..xdir)
		print("zdir: "..zdir)
		print("blockName:: "..blockName)
		print("blockMeta:: "..blockMeta)
		foo()
	end

end 



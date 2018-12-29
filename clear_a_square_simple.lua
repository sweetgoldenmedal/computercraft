silent = false

local args = {...}

square_size = args[1] or 16

if #args < 1 then
    print("hey, you forgot to tell me how big of a square you want me to clear!!!")
    error()
end

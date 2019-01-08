function findBlockByNameMatch(blockName)
    for n=1,16 do
        if turtle.getItemCount(n) ~= 0 then
            local itemDetails = turtle.getItemDetail(n)
            if(string.match(itemDetails.name, blockName)) then
                return n
            end
        end
    end
    print("A block matching: "..blockName.." was not found")
    return false
end

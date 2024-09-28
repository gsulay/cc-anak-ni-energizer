function transfer(from, to, item, amount)
    -- safety for no crash
    if amount == 0 then
        amount = 1
    end
    
    --peripherals
    local left = peripheral.wrap(from)
    local right = peripheral.wrap(to)

    --check if peripheral is valid
    if left == nil then
        print("Left peripheral not found")
        return false
    end
    if right == nil then
        print("Right peripheral not found")
        return false
    end

    --search for slot on left
    local slotNo = 0
    for i =  1, left.size() do
        if left.getItemDetail(i) ~= nil then    --check if slot is empty
            if left.getItemDetail(i)["name"] == item then
                slotNo = i
                break
            end
        end
    end
    
    --transfer
    if slotNo ~= 0 then
        left.pushItems(to, slotNo, amount)
        print("Transferred "..amount.." "..item.." from "..from.." to "..to)
    else
        print("No item found")
        return false
    end

    return true
end



return {transfer = transfer}


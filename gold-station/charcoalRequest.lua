-- requestItem = require("requestItem")
-- local station_name = "gold-station"
-- charcoalInventory = ""
--edit pair 8

function charcoalRun(charcoalInventory, station_name, requestItem, side)
    rednet.open(side)
    charcoalWrapped = peripheral.wrap(charcoalInventory)
    ongoing = false
    while true do
        curCharcoal = 0

        for i=1, 2 do
            curItem = charcoalWrapped.getItemDetail(i)

            if curItem ~= nil then
                if curItem["name"] == "minecraft:charcoal" then
                    curCharcoal = curCharcoal + curItem["count"]
                end
            end
        end

        print("current:Charcoal is at:"..curCharcoal)

        if (curCharcoal < 256) and (ongoing == false) then
            print("Requesting charcoal")
            item1 = requestItem.createItemRequest("minecraft:charcoal", 256)
            request = requestItem.createItemListRequest(nil, station_name, {item1})

            rednet.broadcast(request, "storage-request")
            print("waiting on storage:"..station_name)
            received = false
            while received == false do
                id, message = rednet.receive("storage:"..math.random(5,10))
                if id ~= nil then
                    received = true
                end
            end
            ongoing = true 
            print("Status: "..message)
        end

        --Check if ongoing and pauses until threshold has reached (256)
        if ongoing == true then
            while true do

                itemDetails = charcoalWrapped.list()
                curCharcoal = 0
        
                for i=1, 2 do
                    curItem = charcoalWrapped.getItemDetail(i)
                    if curItem ~= nil then
                        if curItem["name"] == "minecraft:charcoal" then
                            curCharcoal = curCharcoal + curItem["count"]
                        end
                    end
                        
                end

                if curCharcoal >= 256 then
                    ongoing = false
                    print("Charcoal threshold reached")
                    break
                end
            end              
        end
    end
end

return {charcoalRun = charcoalRun}
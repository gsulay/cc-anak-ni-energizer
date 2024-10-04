requestItem = require("requestItem")
local station_name = "gold-station"
charcoalInventory = ""

function charcoalRun(charc, station_name, requestItem)
    charcoalWrapped = peripheral.wrap(charcoalInventory)
    ongoing = false
    while true do
        itemDetails = charcoalWrapped.list()
        curCharcoal = 0

        for i=1, #itemDetails do
            if itemDetails[i]["name"] == "minecraft:charcoal" then
                curCharcoal = curCharcoal + itemDetails[i]["count"]
            end
        end

        if (curCharcoal < 256) and (ongoing == false) then
            item1 = requestItem.createItemRequest("minecraft:charcoal", 256)
            request = requestItem.createItemListRequest(nil, station_name, {item1})

            rednet.broadcast(request, "storage-request")
            id, message = rednet.receive("storage:"..station_name)
            print("Status: "..message)
        end

        --Check if ongoing and pauses until threshold has reached (256)
        if ongoing == true then
            while true do

                itemDetails = charcoalWrapped.list()
                curCharcoal = 0
        
                for i=1, #itemDetails do
                    if itemDetails[i]["name"] == "minecraft:charcoal" then
                        curCharcoal = curCharcoal + itemDetails[i]["count"]
                    end
                end

                if curCharcoal >= 256 then
                    ongoing = false
                    break
                end
            end              
        end
    end
end

return {charcoalRun = charcoalRun}
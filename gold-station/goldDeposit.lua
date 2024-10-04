
function run(input, wrappedStation, side):
    station_name = wrappedStation.getStationName()
    rednet.open(side)
    goldWrapped = peripheral.wrap(input)
    vaulWrapped = peripheral.wrap(output)

    while true do
        curGold = 0
        itemDetails = goldWrapped.list()

        for i=1, #goldWrapped do
            curItem = itemDetails[i]
            
            if curItem~= nil then
                if curItem["name"] == "minecraft:gold_block" then
                    curGold = curGold + curItem["count"]
                end
            end
        end

        if curGold > 128 then
            term.clear()
            print("Gold threshold reached, moving to station")
            received = false
            while received == false do
                id, message = rednet.broadcast({from = station_name, to = "collection-hub"},"train:loading-station")
                if id ~= nil then
                    received = true
                end
            end

            print("Train sent from depot")
            
            --check if train is present
            while true do
                if wrapped_station.isTrainPresent() then
                    break
                end
            end
            print("Moved items to train. Going to sleep")
        end
    end
end

return {run=run}
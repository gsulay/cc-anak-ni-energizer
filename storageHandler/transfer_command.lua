-- local input     = "storagedrawers:controller_0"
-- local output    = "minecraft:chest_2"
-- rednet.open("left")
-- transfer = require("storage_transfer")
-- local transfer_station = "transfer-station"


function run(input, output, transfer_station, transfer)
    while true do
        print("waiting on message...")
        id, message = rednet.receive("storage-request")
        print("Message received: "..tostring(message))
        
        station = message["to"]
        rednet.broadcast("received","storage:"..station)
    
        --check if load not to storage station
        if message["from"] ~= nil then
            --load train
            trainMessage = {to = message["to"], from = message["from"]}
            rednet.broadcast(trainMessage,"train:"..transfer_station)
        
        else --load to storage station
            --transfer items
            for i=1, #message["itemList"] do
                curItemList = message["itemList"][i]
                stat = transfer.transfer(input, output, curItemList["item"], curItemList["amount"])
                print("Transfer status: "..tostring(stat))
            end
            --load train
            trainMessage = {to = message["to"], from = transfer_station}
            rednet.broadcast(trainMessage,"train:"..transfer_station)
        end    
        
    end
end
rednet.open("right")
local station_name = "hub-3"
requestItem = require("requestItem")

item1 = requestItem.createItemRequest("minecraft:oak_planks", 10)
item2 = requestItem.createItemRequest("minecraft:iron_ingot", 10)

-- if from is nil then it is the storage station
request = requestItem.createItemListRequest(nil, station_name, {item1, item2})
            
rednet.broadcast(request, "storage-request")

id, message = rednet.receive("storage:"..station_name)
print("Status: "..message)


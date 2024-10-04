-- local helper = require("helper")
-- local station = peripheral.wrap("left")
-- local side = "right"
--edit pair 6

--function if value is in table
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function run(helper, station, side, mainMon, trainMon)
    rednet.open(side)

    local station_name = station.getStationName()
    while true do

        mainMonCursor = 1
        trainMonCursor = 1
        mainMon.clear()

        mainMon.write("Waiting for message...")
        mainMonCursor = mainMonCursor + 1
        mainMon.setCursorPos(1,mainMonCursor)
        print("Waiting for message on protocol:".."train:"..station_name)
        id, message = rednet.receive("train:"..station_name)

          
        mainMon.write("Message received: "..tostring(message))
        mainMonCursor = mainMonCursor + 1
        mainMon.setCursorPos(1,mainMonCursor)

        from = message["from"]
        to = message["to"]

        --find available train

            --find all train hubs
        all_peripherals = peripheral.getNames()
        all_hub = {}
        for i=1, #all_peripherals do
            cur_peripheral = all_peripherals[i]
            wrapped = peripheral.wrap(cur_peripheral)

            if peripheral.getType(cur_peripheral) == "Create_Station" then
                if wrapped.getStationName() ~= station_name then
                    table.insert(all_hub, wrapped)
                end
            end
        end

            --finds the first available train
        available_hub = nil
        for i=1, #all_hub do
            if all_hub[i].isTrainPresent() then
                available_hub = all_hub[i]
                break
            end
        end

        if available_hub == nil then
            trainMon.write("No available train found")
            trainMonCursor = trainMonCursor + 1
            trainMon.setCursorPos(1,trainMonCursor)
        else
            trainMon.write("Available train found: "..available_hub.getStationName())
            trainMonCursor = trainMonCursor + 1
            trainMon.setCursorPos(1,trainMonCursor)
        end
        
        --     --send train to load station
        -- if available_hub ~= nil then
        --     schedule = helper.loadSingleDestinationSchedule(available_hub.getStationName(), station_name)
        --     available_hub.setSchedule(schedule)
        --     trainMon.write("Schedule loaded from "..available_hub.getStationName().." to "..station_name)
        --     trainMonCursor = trainMonCursor + 1
        --     trainMon.setCursorPos(1,trainMonCursor)
        -- end

        --     --waits for the train to arrive
        -- timer = 0
        -- while true do
        --     if timer > 20 then
        --         print(error("Train not found"))
        --     end
        --     if station.isTrainPresent() then
        --         trainMon.write("Train found")
        --         trainMonCursor = trainMonCursor + 1
        --         trainMon.setCursorPos(1,trainMonCursor)
        --         break
        --     end
        --     timer = timer+1
        --     sleep(1)
        --     -- trainMon.write(1, trainMon)
        --     -- if timer > 10 then
        --     --     print("Train not found")
        --     --     break
        --     -- end
        --     -- timer = timer + 1
        --     -- sleep(1)
        -- end

        --laod train schedule
        schedule = helper.loadIdleSchedule(from, to, available_hub.getStationName())
        available_hub.setSchedule(schedule)
            trainMon.write("Available train found: "..available_hub.getStationName())
            trainMonCursor = trainMonCursor + 1
            trainMon.setCursorPos(1,trainMonCursor)
        trainMon.write("Schedule loaded from "..from.." to "..to)

    end
end

return {run=run}

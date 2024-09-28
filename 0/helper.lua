function delaySchedule(from, to, last, delay1,delay2,delay3)
    -- safety for no crash
    if delay1 == 0 then
        delay1 = 1
    elseif delay2 == 0 then
        delay2 = 1
    elseif delay3 == 0 then
        delay3 = 1
    end
    
    schedule = {
        cyclic = false, -- Does the schedule repeat itself after the end has been reached?
        entries = { -- List of entries, each entry contains a single instruction and multiple conditions.
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = from,
            },
            },
            conditions = {    -- List of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:delay", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = delay1,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = to,
            },
            },
            conditions = {    -- List ,of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:delay", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = delay2,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = last,
            },
            },
            conditions = {    -- List ,of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                    id = "create:delay", -- The different conditions are described below.
                    data = { -- Data that is stored about the condition. Different for each condition type.
                    value = delay3,
                    time_unit = 1,
                    },
                },
                
            },
            },
        }
        },
    }

    return schedule
end


function loadIdleSchedule(from, to, last, loadTime)
    -- safety for no crash
    if loadTime == nil then
        loadTime = 1
    end
    if loadTime == 0 then
        loadTime = 1
    end
    
    schedule = {
        cyclic = false, -- Does the schedule repeat itself after the end has been reached?
        entries = { -- List of entries, each entry contains a single instruction and multiple conditions.
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = from,
            },
            },
            conditions = {    -- List of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:idle", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = 10,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = to,
            },
            },
            conditions = {    -- List ,of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:idle", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = 10,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = last,
            },
            },
            conditions = {    -- List ,of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                    id = "create:idle", -- The different conditions are described below.
                    data = { -- Data that is stored about the condition. Different for each condition type.
                    value = 10,
                    time_unit = 1,
                    },
                },
                
            },
            },
        }
        },
    }
    return schedule
end

function loadSingleDestinationSchedule(from, to)
    -- safety for no crash
    if loadTime == nil then
        loadTime = 1
    end
    if loadTime == 0 then
        loadTime = 1
    end
    
    schedule = {
        cyclic = false, -- Does the schedule repeat itself after the end has been reached?
        entries = { -- List of entries, each entry contains a single instruction and multiple conditions.
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = from,
            },
            },
            conditions = {    -- List of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:delay", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = 2,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        {
            instruction = {
            id = "create:destination", -- The different instructions are described below.
            data = { -- Data that is stored about the instruction. Different for each instruction type.
                text = to,
            },
            },
            conditions = {    -- List ,of lists of conditions. The outer list is the "OR" list
            {               -- and the inner lists are "AND" lists.
                {
                id = "create:delay", -- The different conditions are described below.
                data = { -- Data that is stored about the condition. Different for each condition type.
                    value = 2,
                    time_unit = 1,
                    },
                },
                
            },
            },
        },
        },
    }
    return schedule
end
return {delaySchedule=delaySchedule, 
        loadIdleSchedule=loadIdleSchedule,
        loadSingleDestinationSchedule=loadSingleDestinationSchedule}
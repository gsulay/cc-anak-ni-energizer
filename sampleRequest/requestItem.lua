
function createItemRequest(item,amount)
    --returns a table of item and amount
    return {item = item, amount = amount}
end

function createItemListRequest(from, to, itemList)
    newTable = {
        from = from,
        to = to,
        itemList = itemList
    }
    return 
end

return {createItemRequest = createItemRequest,
        createItemListRequest = createItemListRequest}



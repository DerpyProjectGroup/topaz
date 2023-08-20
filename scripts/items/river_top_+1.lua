-----------------------------------
-- ID: 10270
-- River Top +1
-- Dispense: Berry Snowcone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addItem(xi.items.BERRY_SNOW_CONE, 1)
end

return itemObject
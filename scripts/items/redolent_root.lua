-----------------------------------
-- ID: 5904
-- Item: Redolent Root
-----------------------------------


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    elseif target:getName() == 'Cirrate_Christelle' or target:getName() == 'Arch_Christelle' then
        return 0
    else
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return result
end

itemObject.onItemUse = function(target, player)
    if target:getLocalVar('itemDebuff_Root') == 1 then
        target:setLocalVar('itemDebuff_Root', 0)
        target:updateClaim(player)
    end
end

return itemObject

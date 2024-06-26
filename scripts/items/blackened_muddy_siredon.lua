-----------------------------------
-- ID: 5266
-- Item: Blackened Muddy Siredone
-- Item Effect: Temporarily removes Shikaree TP moves
-----------------------------------
local ID = require('scripts/zones/Boneyard_Gully/IDs')


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = xi.msg.basic.ITEM_UNABLE_TO_USE

    if (target:getID() >= ID.mob.SHIKAREE_HEADWIND_START or target:getID() <= ID.mob.SHIKAREE_HEADWIND_END) then
        result = 0
    elseif target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

itemObject.onItemUse = function(target, player)
    target:addStatusEffect(xi.effect.AMNESIA, 1, 0, 60)
end

return itemObject

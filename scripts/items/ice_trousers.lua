-----------------------------------
-- ID: 15651
-- Item: Ice Trousers
-- Item Effect: Ice Spikes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ICE_SPIKES, 15, 0, 180, 0, 0, 0, xi.item.ICE_TROUSERS)
end

return itemObject

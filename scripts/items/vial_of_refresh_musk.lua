-----------------------------------
-- ID: 18241
-- Item: Vial of Refresh Musk
-- Item Effect: 60 seconds
-- Duration: 30 Seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.REFRESH)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.item.VIAL_OF_REFRESH_MUSK
    then
        target:delStatusEffect(xi.effect.REFRESH)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.VIAL_OF_REFRESH_MUSK) then
        target:addStatusEffect(xi.effect.REFRESH, 3, 3, 60, 0, 0, 0, xi.item.VIAL_OF_REFRESH_MUSK)
    end
end

return itemObject

-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.VIT_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.TOUGH_BELT then
        target:delStatusEffect(xi.effect.VIT_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.TOUGH_BELT) then
        target:addStatusEffect(xi.effect.VIT_BOOST, 3, 0, 60, 0, 0, 0, xi.item.TOUGH_BELT)
    end
end

return itemObject

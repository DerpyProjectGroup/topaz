-----------------------------------
-- ID: 15610
-- Item: sturdy_trousers
-- Item Effect: HP +10
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.MAX_HP_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.STURDY_TROUSERS then
        target:delStatusEffect(xi.effect.MAX_HP_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.STURDY_TROUSERS) then
        target:addStatusEffect(xi.effect.MAX_HP_BOOST, 10, 0, 1800, 0, 0, 0, xi.item.STURDY_TROUSERS)
    end
end

return itemObject

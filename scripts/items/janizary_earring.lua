-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.DEFENSE_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.JANIZARY_EARRING then
        target:delStatusEffect(xi.effect.DEFENSE_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.JANIZARY_EARRING) then
        target:addStatusEffect(xi.effect.DEFENSE_BOOST, 32, 0, 180, 0, 0, 0, xi.item.JANIZARY_EARRING)
    end
end

return itemObject

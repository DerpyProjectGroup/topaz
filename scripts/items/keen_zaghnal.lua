-----------------------------------
-- ID: 18067
-- Equip: Keen Zaghnal
--  Enchantment: Accuracy +3
-- Enchantment will wear off if weapon is unequipped.
--  Effect lasts for 30 minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.ACCURACY_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.KEEN_ZAGHNAL then
        target:delStatusEffect(xi.effect.ACCURACY_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.KEEN_ZAGHNAL) then
        target:addStatusEffect(xi.effect.ACCURACY_BOOST, 3, 0, 1800, 0, 0, 0, xi.item.KEEN_ZAGHNAL)
    end
end

return itemObject

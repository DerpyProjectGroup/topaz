-----------------------------------
-- ID: 17826
-- Item: Messhikimaru
-- Enchantment: Arcana Killer
-- Durration: 10 Mins
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.ARCANE_CIRCLE)
    if effect ~= nil and effect:getItemSourceID() == xi.item.MESSHIKIMARU then
        target:delStatusEffect(xi.effect.ARCANE_CIRCLE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MESSHIKIMARU) then
        target:addStatusEffect(xi.effect.ARCANE_CIRCLE, 20, 0, 600, 0, 0, 0, xi.item.MESSHIKIMARU)
    end
end

return itemObject

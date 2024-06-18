-----------------------------------
-- ID: 15870
-- Item: maharajas_belt
-- Item Effect: AGI +10
-- Duration: 60 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.MAHARAJAS_BELT) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.MAHARAJAS_BELT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MAHARAJAS_BELT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.item.MAHARAJAS_BELT)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 10)
end

return itemObject

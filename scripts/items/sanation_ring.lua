-----------------------------------
-- ID: 14677
-- Item: Sanation Ring
-- Item Effect: MP recovered while healing +3
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.SANATION_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.SANATION_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SANATION_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.item.SANATION_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject

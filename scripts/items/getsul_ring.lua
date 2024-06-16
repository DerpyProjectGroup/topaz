-----------------------------------
-- ID: 14681
-- Item: Getsul Ring
-- Item Effect: +20% HP
-- Duration 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.GETSUL_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.item.GETSUL_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.GETSUL_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.item.GETSUL_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPP, 20)
end

return itemObject

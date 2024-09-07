-----------------------------------
-- ID: 15863
-- Item: samsonian_belt
-- Item Effect: STR +3
-- Duration: 60 seconds
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, caster, item)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 3)
end

return itemObject

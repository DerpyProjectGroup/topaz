-----------------------------------
-- ID: 14786
-- Item: Counter Earring
-- Item Effect: Counter 5%
-- Duration: 3 Minutes
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.COUNTER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

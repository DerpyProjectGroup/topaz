-----------------------------------
-- ID: 18239
-- Item: Healing Feather
-- Item Effect: Cure Potency +15%
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 300, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CURE_POTENCY, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

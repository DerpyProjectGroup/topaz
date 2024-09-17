-----------------------------------
-- Item: Death Chakram
-- Item Effect: +5% MP
-- Duration 3 Minutes
-----------------------------------

-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    return 0
end

itemObject.onItemUse = function(target, caster, item)
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.MAX_MP_BOOST, 0, 0, 300, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MPP, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

-----------------------------------
-- ID: 13144
-- Item: wing gorget
-- Item Effect: gives regain
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
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.REGAIN, 0, 0, 30, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.REGAIN, 50)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

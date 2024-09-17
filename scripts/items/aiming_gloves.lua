-----------------------------------
-- ID: 14957
-- Item: aiming_gloves
-- Item Effect: Ranged Accuracy +3
-- Duration: 60 seconds (Needs confirmation)
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
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.SHARPSHOT, 0, 0, 300, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.RACC, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

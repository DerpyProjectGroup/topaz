-----------------------------------
-- ID: 15505
-- Item: dhalmel_whistle
-- Item Effect: AGI +6
-- Duration: 3 minutes
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
    effect:addMod(xi.mod.AGI, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

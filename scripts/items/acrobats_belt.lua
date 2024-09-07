-----------------------------------
-- ID: 15866
-- Item: acrobats_belt
-- Item Effect: AGI +3
-- Duration: 60 seconds
-----------------------------------

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
    effect:addMod(xi.mod.AGI, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

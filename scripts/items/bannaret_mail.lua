-----------------------------------
-- ID: 14531
-- Item: bannaret_mail
-- Item Effect: HP +15, Enmity +2
-- Duration: 30 Minutes
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HP, 15)
    effect:addMod(xi.mod.ENMITY, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

-----------------------------------
-- ID: 15487
-- Item: High Breath Mantle
-- Item Effect: HP+38 / Enmity+5
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
    effect:addMod(xi.mod.HP, 38)
    effect:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

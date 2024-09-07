-----------------------------------
-- ID: 15290
-- Item: Haste Belt
-- Item Effect: 10% haste
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

    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.HASTE, 0, 0, 180, item:getID())
end

itemObject.onItemUnequip = function(user, item)
    local effect = user:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HASTE_MAGIC, 1000)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
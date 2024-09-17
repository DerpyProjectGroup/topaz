-----------------------------------------
-- ID: 15462
-- Item: Sagacious Brocade Obi
-- Effect: 10Min, INT +10
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    return 0
end

itemObject.onItemUse = function(target, caster, item)
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.INT_BOOST_II, 0, 0, 600, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.INT, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

-----------------------------------
-- ID: 15861
-- Item: deductive_brocade_obi
-- Item Effect: MND+10
-- Duration: 3 Minutes
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
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.MND_BOOST_II, 0, 0, 300, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MND, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject

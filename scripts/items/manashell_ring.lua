-----------------------------------
-- ID: 15782
-- Item: Manashell Ring
-- Item Effect: MP +9
-- Duration: 3 minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if
        effect and
        caster
    then
        local effectCount = target:countEffectBySubID(xi.effect.ENCHANTMENT, item:getID())
        if
            effect:getSubType() == item:getID() and
            effectCount >= 2
        then
            caster:printToPlayer(('Only 2 Enchantment effects can be active from a unique Ring/Earring item.'), xi.msg.channel.SYSTEM_3)
            return xi.msg.basic.ITEM_UNABLE_TO_USE_2
        end
    end

    return 0
end

itemObject.onItemUnequip = function(target, item)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end
end

itemObject.onItemUse = function(target, caster, item)
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.MAX_MP_BOOST, 0, 0, 1800, item:getID(), 0, 0, false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MP, 9)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
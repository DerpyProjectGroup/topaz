-----------------------------------
-- ID: 15553
-- Penguin Ring
-- Enchantment: Increases skill at tiring fish.
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
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.ENCHANTMENT, 0, 0, 1200, item:getID(), false)
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.PENGUIN_RING_EFFECT, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
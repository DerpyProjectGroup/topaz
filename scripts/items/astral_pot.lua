-----------------------------------
-- ID: 18243
-- Item: Astral Pot
-- Item Effect: Pet Magical Attack +22
-- Duration 5 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local pet = target:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0
end

itemObject.onItemUse = function(target, caster, item)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 300, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    pet:addMod(xi.mod.MATT, 22)
end

itemObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet ~= nil then
        pet:delMod(xi.mod.MATT, 22)
    end
end

return itemObject

-----------------------------------
-- ID: 18029
-- Item: piercing_dagger
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.ATTACK_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.PIERCING_DAGGER then
        target:delStatusEffect(xi.effect.ATTACK_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PIERCING_DAGGER) then
        target:addStatusEffect(xi.effect.ATTACK_BOOST, 3, 0, 1800, 0, 0, 0, xi.item.PIERCING_DAGGER)
    end
end

return itemObject

-----------------------------------
-- ID: 15770
-- Item: Random Ring
-- Item Effect: DEX + 1~8
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.DEX_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.RANDOM_RING then
        target:delStatusEffect(xi.effect.DEX_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local power = math.random(1, 8)

    if target:hasEquipped(xi.item.RANDOM_RING) then
        target:addStatusEffect(xi.effect.DEX_BOOST, power, 0, 300, 0, 0, 0, xi.item.RANDOM_RING)
    end
end

return itemObject

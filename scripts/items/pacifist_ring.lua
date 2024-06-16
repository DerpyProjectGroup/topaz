-----------------------------------
-- ID: 14680
-- Item: Pacifist Ring
-- Item Effect: Enmity -12
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.ENMITY_DOWN)
    if effect ~= nil and effect:getItemSourceID() == xi.item.PACIFIST_RING then
        target:delStatusEffect(xi.effect.ENMITY_DOWN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.PACIFIST_RING) then
        target:addStatusEffect(xi.effect.ENMITY_DOWN, 12, 0, 180, 0, 0, 0, xi.item.PACIFIST_RING)
    end
end

return itemObject

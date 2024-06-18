-----------------------------------
-- ID: 15782
-- Item: Manashell Ring
-- Item Effect: MP +9
-- Duration: 3 minutes
-----------------------------------


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.MAX_MP_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.MANASHELL_RING then
        target:delStatusEffect(xi.effect.MAX_MP_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MANASHELL_RING) then
        target:addStatusEffect(xi.effect.MAX_MP_BOOST, 9, 0, 180, 0, 0, 0, xi.item.MANASHELL_RING)
    end
end

return itemObject

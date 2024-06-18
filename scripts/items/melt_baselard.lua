-----------------------------------
-- ID: 18012
-- Item: Melt Baselard
-- Item Effect: MP +9
-- Duration:
-----------------------------------


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.MAX_MP_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.MELT_BASELARD then
        --target:delStatusEffect(xi.effect.EN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    --target:addStatusEffect(xi.effect.EN, 9, 0, 180, 0, 0, 0, xi.item.MELT_BASELARD)
end

return itemObject

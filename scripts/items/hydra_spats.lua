-----------------------------------
-- ID: 15681
-- Item: hydra_spats
-- Item Effect: Eva +15
-- Duration: 20 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.EVASION_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.item.HYDRA_SPATS then
        target:delStatusEffect(xi.effect.EVASION_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_SPATS) then
        target:addStatusEffect(xi.effect.EVASION_BOOST, 15, 0, 1200, 0, 0, 0, xi.item.HYDRA_SPATS)
    end
end

return itemObject

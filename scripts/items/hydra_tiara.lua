-----------------------------------
-- ID: 15261
-- Item: hydra_tiara
-- Item Effect: Crit Rate +7% **Needs validation**
-- Duration: 3 Minutes
-----------------------------------

-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.POTENCY)
    if effect ~= nil and effect:getItemSourceID() == xi.item.HYDRA_TIARA then
        target:delStatusEffect(xi.effect.POTENCY)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HYDRA_TIARA) then
        target:addStatusEffect(xi.effect.POTENCY, 7, 0, 180, 0, 0, 0, xi.item.HYDRA_TIARA)
    end
end

return itemObject

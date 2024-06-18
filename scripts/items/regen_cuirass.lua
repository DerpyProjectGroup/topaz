-----------------------------------
-- ID: 13823
-- Item: regen cuirass
-- Item Effect: gives regen
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local effect = target:getStatusEffect(xi.effect.REGEN)
    if effect ~= nil and effect:getItemSourceID() == xi.item.REGEN_CUIRASS then
        target:delStatusEffect(xi.effect.REGEN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.REGEN_CUIRASS) then
        if target:hasStatusEffect(xi.effect.REGEN) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(xi.effect.REGEN, 5, 3, 75, 0, 0, 0, xi.item.REGEN_CUIRASS)
        end
    end
end

return itemObject

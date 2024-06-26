-----------------------------------
-- ID: 5905
-- Item: Undying Moiety
-- Item Effect: Removes Antaeus's damage reductions.
-----------------------------------


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0

    if target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    elseif target:getName() == 'Antaeus' or target:getName() == 'Arch_Antaeus' then
        return 0
    else
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return result
end

itemObject.onItemUse = function(target, player)
    if target:getLocalVar('AntaeusDMG') == 1 then
        target:setMod(xi.mod.UDMGRANGE, 0)
        target:setMod(xi.mod.UDMGPHYS, 0)
        target:setMod(xi.mod.UDMGMAGIC, 0)
        target:setMod(xi.mod.UDMGBREATH, 0)
        target:setLocalVar('AntaeusDMG', 0)
        target:updateClaim(player)
    end
end

return itemObject

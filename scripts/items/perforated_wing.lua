-----------------------------------
-- ID: 5904
-- Item: Perforated Wing
-- Item Effect: Removes Antaeus's 100% Critical Hit Rate.
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
    if target:getLocalVar('AntaeusCrit') == 1 then
        target:setMod(xi.mod.CRITHITRATE, 10)
        target:setLocalVar('AntaeusCrit', 0)
        target:updateClaim(player)
    end
end

return itemObject

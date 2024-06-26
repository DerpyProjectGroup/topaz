-----------------------------------
-- ID: 5900
-- Item: Shadescale Talon
-- Item Effect: Removes Apocalyptic Beast's PetroEyes & Chaos Blade
-----------------------------------


-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:checkDistance(caster) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    elseif target:getName() == 'Apocalyptic_Beast' or target:getName() == 'Arch_Apocalyptic_Beast' then
        return 0
    else
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return result
end

itemObject.onItemUse = function(target, player)
    if target:getLocalVar('debuff_Talon') == 0 then
        target:setLocalVar('debuff_Talon', 1)
        target:updateClaim(player)
    end
end

return itemObject

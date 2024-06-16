-----------------------------------
-- ID: 14656
-- Item: Poseidon's Ring
-- Effect: Summon Water Spirit Pet
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if target:hasPet() then
        result = xi.msg.basic.ALREADY_HAS_A_PET
    elseif not target:canUseMisc(xi.zoneMisc.PET) then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return result
end

itemObject.onItemUse = function(target)
    xi.pet.spawnPet(target, xi.petId.WATER_SPIRIT)
end

return itemObject
